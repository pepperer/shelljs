#!/usr/bin/env bash
#
#function check(){
#    local a="$1"
#    printf "%d" "$a" &>/dev/null && echo "integer" && return
#    printf "%d" "$(echo $a|sed 's/^[+-]\?0\+//')" &>/dev/null && echo "integer" && return
#    printf "%f" "$a" &>/dev/null && echo "number" && return
#    [ ${#a} -eq 1 ] && echo "char" && return
#    echo "string"
#}
#
# 获取当前地址
path=`pwd`
# echo ${path}

##### 查看当前地址的setting 文件
settingPath=${path}/settings.gradle
# echo  settings.gradle路径为:${settingPath}
#
#
if [[ ! -f ${settingPath} ]]; then
   echo ${settingPath} NOT FOUND
   exit
fi

modules=`egrep -o '(:)([a-zA-Z_-]+)' $settingPath`

# 测试答应结构
# echo "数组的元素为: ${modules[*]}"  


targetModules=()
for loop in ${modules[*]}
do
    value=$(echo ${loop:1} | tr [A-Z] [a-z])    # 将name1全部转变成大写再做比较
    if [[ $value = "tuyasmart_appshell" ]]; then
       continue
    fi
    targetModules=(${targetModules[*]} ${value})
   # echo "${targetModules} The value is: ${value}"
done

# 测试答应结构
#echo "请输入你要upload的index: ${targetModules[*]}"  

echo '请输入你要上传模块对应的索引 ==> '
for i in ${!targetModules[@]}
do
echo "$i: ${targetModules[$i]}"
done

read index 
module=${targetModules[$index]}
echo "执行的命令为 ===> ./gradlew ${module}:upload"
./gradlew ${name}:upload
