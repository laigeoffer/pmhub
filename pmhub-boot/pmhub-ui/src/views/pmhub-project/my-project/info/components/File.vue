<template>
  <div class="app-container" v-loading="loading">
    <!-- search-wrapper 模块 -->
    <el-card shadow="never" class="search-wrapper">
      <el-form ref="searchFormRef" :inline="true" :model="searchData" @submit.native.prevent>
        <el-form-item prop="fileName" label="文件名">
          <el-input v-model="searchData.fileName" placeholder="请输入文件名" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button @click="handleResetForm('searchFormRef')">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <!-- toolbar-wrapper 模块 -->
    <el-card shadow="never" class="toolbar-wrapper">
      <el-upload
        :action="uploadFileUrl"
        :headers="uploadFileHeaders"
        :data="uploadFileData"
        :show-file-list="false"
        :auto-upload="true"
        :before-upload="handleBeforeUpload"
        :on-success="handleUploadSuccess"
        :on-error="handleUploadError"
      >
        <el-button type="primary">上传</el-button>
      </el-upload>
      <el-button type="primary" @click="handleBatchDownloads">批量下载</el-button>
      <el-button type="danger" @click="handleBatchDelete">批量删除</el-button>
    </el-card>
    <el-card shadow="never">
      <!-- table-wrapper 模块 -->
      <el-table class="table-wrapper" :data="tableData" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"> </el-table-column>
        <el-table-column label="文件名" prop="fileName" align="center" />
        <el-table-column label="所属对象" prop="name" align="center" />
        <el-table-column label="上传人" prop="nickName" align="center" />
        <el-table-column label="文件大小（KB）" prop="fileSize" align="center" />
        <el-table-column label="上传时间" prop="createdTime" align="center" />
        <el-table-column label="操作" align="center" width="210">
          <template slot-scope="scope">
            <el-button type="text" @click="handleDownload(scope.row)">下载</el-button>
            <el-button type="text" @click="handleRename(scope.row)">重命名</el-button>
            <el-button type="text" @click="handleDelete(scope.row)" style="color: #f56c6c">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <!-- pager-wrapper 模块 -->
      <div class="pager-wrapper">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next, jumper"
          :page-sizes="[10, 20, 50]"
          :total="total"
          :page-size="pageSize"
          :current-page="currentPage"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        >
        </el-pagination>
      </div>
    </el-card>
  </div>
</template>

<script>
import { getFileListApi, deleteFileApi, renameFileApi } from "@/api/pmhub-project/my-project.js"
import { getToken } from "@/utils/auth"

export default {
  name: "MyProjectInfoFile",
  components: {},
  props: {
    // 项目基本数据
    projectData: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      loading: false,

      /* search-wrapper 模块 */
      searchData: {
        fileName: "",
      },

      /* toolbar-wrapper 模块 */
      uploadFileUrl: process.env.VUE_APP_BASE_API + "/project/file/upload",
      uploadFileHeaders: { Authorization: "Bearer " + getToken() },
      uploadFileData: { id: this.projectData.projectId, type: "project" },

      /* table-wrapper 模块 */
      multipleSelection: [],
      tableData: [],

      /* pager-wrapper 模块 */
      total: 0,
      currentPage: 1,
      pageSize: 10,
    }
  },
  methods: {
    /* search-wrapper 模块 */
    handleSearch() {
      this.currentPage = 1
      this.getTableData()
    },
    handleResetForm(ref) {
      this.$refs[ref].resetFields()
      this.getTableData()
    },

    /* toolbar-wrapper 模块 */
    handleBeforeUpload() {
      // 上传文件之前触发
      this.loading = true
      // const isLt50M = file.size / 1024 / 1024 < 50
      // if (!isLt50M) {
      //   this.$message.error("上传文件大小不能超过 50MB!")
      // }
      // return isLt50M
    },
    handleUploadError() {
      // 上传失败时触发
      this.loading = false
      this.$modal.msgError("上传文件失败")
    },
    handleUploadSuccess(res, file) {
      // 上传成功时触发
      this.loading = false
      if (res.code === 200) {
        this.$modal.msgSuccess("上传文件成功")
        this.getTableData()
      } else {
        this.$modal.msgError(res.msg || "上传文件异常")
      }
    },
    handleBatchDownloads() {
      if (this.multipleSelection.length === 0) return
      const data = {
        projectFileIds: "",
      }
      for (let i = 0; i < this.multipleSelection.length; i++) {
        data.projectFileIds += this.multipleSelection[i].projectFileId + ","
      }
      this.download("/project/file/batchDownload", data, "批量下载.zip")
    },
    handleBatchDelete() {
      if (this.multipleSelection.length === 0) return
      const data = {
        fileVOList: [],
      }
      for (let i = 0; i < this.multipleSelection.length; i++) {
        data.fileVOList.push({
          projectFileId: this.multipleSelection[i].projectFileId,
          fileUrl: this.multipleSelection[i].fileUrl,
        })
      }
      this.$modal
        .confirm(`是否确认删除所选文件？`)
        .then(() => {
          return deleteFileApi(data)
        })
        .then(() => {
          this.$modal.msgSuccess("批量删除成功")
          this.getTableData()
          this.multipleSelection = []
        })
        .catch(() => {})
    },

    /* table-wrapper 模块 */
    getTableData() {
      this.loading = true
      getFileListApi({
        pageNum: this.currentPage,
        pageSize: this.pageSize,
        fileName: this.searchData.fileName,
        id: this.projectData.projectId,
        type: undefined,
      })
        .then((res) => {
          this.total = res.data.total
          this.tableData = res.data.list
        })
        .catch(() => {
          this.tableData = []
        })
        .finally(() => {
          this.loading = false
        })
    },
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    handleDownload(row) {
      this.download(
        "/project/file/download",
        {
          projectFileId: row.projectFileId,
          fileUrl: row.fileUrl,
        },
        row.fileName
      )
    },
    handleRename(row) {
      this.$prompt(`当前名称：${row.fileName}`, "重命名", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
      })
        .then(({ value }) => {
          const fileNameArray = row.fileName.split(".")
          if (fileNameArray.length < 2) {
            return Promise.reject(new Error("重命名程序异常"))
          }
          const suffix = fileNameArray[fileNameArray.length - 1]
          return renameFileApi({
            projectFileId: row.projectFileId,
            fileName: value + "." + suffix,
            fileUrl: row.fileUrl,
          })
        })
        .then(() => {
          this.$modal.msgSuccess("重命名成功")
          this.getTableData()
        })
        .catch(() => {
          this.$modal.msgError("重命名程序异常")
        })
    },
    handleDelete(row) {
      const data = {
        fileVOList: [
          {
            projectFileId: row.projectFileId,
            fileUrl: row.fileUrl,
          },
        ],
      }
      this.$modal
        .confirm(`是否确认删除文件：${row.fileName}？`)
        .then(() => {
          return deleteFileApi(data)
        })
        .then(() => {
          this.$modal.msgSuccess("删除成功")
          this.getTableData()
        })
        .catch(() => {})
    },

    /** pager-wrapper 模块 */
    handleCurrentChange(value) {
      this.currentPage = value
      this.getTableData()
    },
    handleSizeChange(value) {
      this.pageSize = value
      this.getTableData()
    },
  },
  mounted() {
    this.getTableData()
  },
}
</script>

<style scoped lang="scss">
.search-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    padding-bottom: 2px;
  }
}

.toolbar-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    display: flex;
    .el-upload {
      margin-right: 10px;
    }
  }
}

.table-wrapper {
  margin-bottom: 20px;
}

.pager-wrapper {
  display: flex;
  justify-content: flex-end;
}
</style>
