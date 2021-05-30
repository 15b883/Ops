import requests
from locust import HttpUser, TaskSet, task
from requests.packages.urllib3.exceptions import InsecureRequestWarning

# 禁用安全请求警告
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)


class MyBlogs(TaskSet):
    # 访问我的博客首页
    @task(1)
    def get_blog(self):
        # 定义请求头
        header = {
            # windows10
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36"}
        # 首页目录 /
        req = self.client.get("/", headers=header, verify=False)
        if req.status_code == 200:
            print("success")
        else:
            print("fails")


class websitUser(HttpUser):
    tasks = [MyBlogs]
    min_wait = 3000  # 单位为毫秒
    max_wait = 6000  # 单位为毫秒


if __name__ == "__main__":
    import os
    # # test-tools是本测试脚本名称  --host 要测试的网站
    os.system("locust -f test-tools.py --host=https://baidu.com")
