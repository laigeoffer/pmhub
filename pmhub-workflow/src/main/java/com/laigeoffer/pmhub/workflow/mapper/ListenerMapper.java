package com.laigeoffer.pmhub.workflow.mapper;

import com.laigeoffer.pmhub.workflow.domain.vo.TaskCompletedStateVO;
import com.laigeoffer.pmhub.workflow.domain.vo.TodoNumVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 监听器需要的mapper
 * @author canghe
 */
@Mapper
public interface ListenerMapper {

    /**
     * 获取任务完成时状态
     * @param id 传入id
     * @return 状态code
     * */
    public TaskCompletedStateVO getTaskCompletedState(String id);


    /**
     * 获取流程结束时最后一个任务的状态
     * @param instId 传入流程id
     * @return 状态code
     * */
    public TaskCompletedStateVO getLastTaskCompletedState(String instId);

    /**
     * 获取流程名称
     * @param processDefinitionId 流程id
     * @return 流程名称
     * */
    public String getProcessName(String processDefinitionId);

    /**
     * 获取DeployId
     * @param id 传入taskid
     * @return DeployId
     * */
    public String getDeployId(String id);


    /**
     * 获取DeployId
     * @param definitionId definitionId
     * @return DeployId
     * */
    public String getDeployByDefinitionId(String definitionId);


    /**
     * 获取 TaskId
     * @param instId instId
     * @return TaskId
     * */
    public String getTaskId(String instId);

    /**
     * 获取 分类名
     * @param deployId deployId
     * @return 分类名
     * */
    public String getProcessTypeName(String deployId);


    /**
     * 查询流程下所有用户任务
     * @param instId instId
     * @return taskID
     * */
    public List<String> getAllTaskId(String instId);


    /**
     * 查询详情url
     * @param instId  instId
     * @return 详情url
     * */
    public String getDetailUrlByInstId(String instId);


    /**
     * 获取所有有企微账号的用户的代办任务数量
     * @return 代办任务和企微账号
     * */
    public List<TodoNumVO> getTodoNumList();
}
