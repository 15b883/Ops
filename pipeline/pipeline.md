

安装声明式插件

```
Declarative
```



## Jenkinsfile 组成

* 指定node节点、workspace
* 指定运行选择
* 指定stages阶段
* 指定构建后的操作

## agent

```

String workspace = "/docker/data/jenkins/workspace"

agent { node {	label "master"     // 执定运行节点的标签或者名称
				customWorkspace "${workspace}"   // 指定运行工作目录（可选）
		}
}

options {
	timestamps() //日志会有时间
	skipDefaultCheckout() // 删除隐式checkout scm语句
	disableConcurrentBuilds() // 禁止并行
	timeout(time: 1, unit: 'HOURS') // 流水线超时设置1小时
}
```

agnet 指定了流水线的执行节点

参数

* any 在任何可用的节点上执行pipeline
* none 没有指定agent的时候默认
* label 在指定标签上的节点上运行pipeline
* node  允许额外的选项

```
agent {node { label 'labelname' }}
agent {label 'labelname'}
```

## stages

```
stages {
	// 下载代码
	stage("GetCode"){  // 阶段名称
		steps{  // 步骤
			timeout(time:5, unit:"MINUTES"){ // 步骤超时时间
				script{ //填写运行代码
					println('获取代码')
				}
			}
		}
	}
	// 构建
	stage("Build"){  // 阶段名称
		steps{  // 步骤
			timeout(time:20, unit:"MINUTES"){ // 步骤超时时间
				script{ //填写运行代码
					println('应用打包')
				}
			}
		}
	}
    
    // 代码扫描
	stage("CodeScan"){  // 阶段名称
		steps{  // 步骤
			timeout(time:30, unit:"MINUTES"){ // 步骤超时时间
				script{ //填写运行代码
					println('代码扫描')
				}
			}
		}
	}    
}
```

## post

```
// 构建后操作
post {
	always {
		scriptt{
			println("always")
		}
	}
	
	success {
		script{
			currentBuild.description += "\n 构建成功"
		}
	}
	
	failure {
		script{
			currentBuild.description += "\n 构建失败"
		}
	}
    
	aborted {
		script{
			currentBuild.description += "\n 构建取消"
		}
	}    
}
```

* always{} 总是执行脚本片段
* changed 只有当流水线或者阶段完成状态与之前不同时
* success{} 成功后执行
* failure{}   失败后执行
* aborted   取消后执行

* unstable 只有当流水线或者阶段状态为 unstable 运行。例如 测试失败

* currendBuild 是一个全局变量

* description 构建描述