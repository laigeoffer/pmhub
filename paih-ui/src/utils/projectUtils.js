export function projectStatus(list) {
  list.forEach((element) => {
    element.status == 4
      ? (element.disabled = true,element.projectName+=" (已暂停)")
      : (element.disabled = false);
  });
}
