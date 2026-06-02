# 📦 RuoYi Office 简化版 - OA 协同办公平台

## ⚡ 简介

这是 **RuoYi Office** 的简化版本，经过精简配置后，仅保留：

- ✅ **🏠 OA 协同办公** - 用车管理、印章管理、会议室管理、企业云盘
- ✅ **⚙️ BPM 流程引擎** - 工作流程、审批流程  
- ✅ **🔧 系统管理** - 用户、角色、权限、菜单管理
- ✅ **🔩 基础设施** - 代码生成、文件存储、日志管理

## 🎯 项目结构（简化版）

### 后端模块

| 模块 | 说明 |
|:---|:---|
| `yudao-dependencies` | Maven 依赖版本管理 |
| `yudao-framework` | Java 框架核心拓展 |
| `yudao-gateway` | Spring Cloud 微服务网关 |
| `yudao-server` | 管理后台服务端 |
| `yudao-module-system` | 系统管理（用户/角色/权限/菜单） |
| `yudao-module-infra` | 基础设施（代码生成/文件/日志） |
| `yudao-module-bpm` | 工作流程引擎 |
| `yudao-module-oa` | **OA 协同办公** |

### 已删除的模块

❌ HRM（人力资源）| CRM（客户管理）| ERP（进销存）| Asset（资产）| WMS（仓储）| Member（会员）| Pay（支付）| Report（报表）| MP（公众号）| Mall（商城）| AI（大模型）| IoT（物联网）

## 🚀 快速开始

### 环境要求

| 环境 | 版本要求 |
|:---|:---|
| JDK | 17 或 21 |
| MySQL | 5.7+ 或 8.0+ |
| Redis | 5.0+ |
| Node.js | 18+ |
| Maven | 3.9+ |
| Nacos | 2.x |

### 后端启动

```bash
# 1. 克隆项目
git clone -b simplify/oa-only https://github.com/jonesue1992/ruoyi-office.git
cd ruoyi-office

# 2. 导入数据库（使用简化版 SQL，仅包含 OA 相关表）
mysql -u root -p < sql/mysql/ruoyi-vue-pro.sql

# 3. 编译构建
mvn clean install -DskipTests

# 4. 启动后端（单体模式）
java -jar yudao-server/target/yudao-server.jar

# 或微服务模式：先启动 Nacos，再启动各个模块
```

### 前端启动

```bash
# 1. 进入前端目录
cd yudao-ui/yudao-ui-admin-vben

# 2. 安装依赖
pnpm install

# 3. 启动开发服务器
npm run dev:antd

# 4. 访问系统
# 地址：http://localhost:5173
# 账号：admin
# 密码：admin123
```

## 📊 核心功能

### 🏠 OA 协同办公

| 功能模块 | 功能描述 |
|:---|:---|
| 🚗 用车管理 | 公务车辆登记、用车申请、用车审批、车辆归还 |
| 🔏 印章管理 | 印章登记、用印申请、用印审批、用印记录追溯 |
| 🏢 会议室管理 | 会议室资源管理、在线预约、时间冲突检测 |
| 📁 企业云盘 | 文件上传/下载、目录管理、文件共享、权限控制 |

### ⚙️ BPM 流程引擎

- 仿钉钉/飞书可视化设计器
- BPMN 标准设计器
- 支持会签、或签、依次审批
- 支持转办、委派、加签、减签等操作

### 🔧 系统管理

- 用户管理、角色管理、权限管理
- 菜单管理、部门管理、岗位管理
- 多租户 SaaS 支持
- 数据权限隔离

## 🛠️ 技术架构

| 层级 | 技术选型 | 版本 |
|:---|:---|:---|
| **微服务框架** | Spring Cloud Alibaba + Spring Boot | 2025.0.0 / 3.5.x |
| **服务网关** | Spring Cloud Gateway | Latest |
| **注册/配置中心** | Nacos | 2.x |
| **消息队列** | RocketMQ | 5.x |
| **工作流引擎** | Flowable | 7.0.x |
| **前端框架** | Vue 3 + Vben Admin + TypeScript | 3.5 / 5.8 |
| **ORM** | MyBatis Plus | 3.5.x |
| **缓存** | Redis + Redisson | 6.x / 3.50 |
| **数据库** | MySQL / PostgreSQL 等 | 多版本 |

## 📝 开发指南

### 目录结构

```
ruoyi-office/
├── yudao-dependencies/       # Maven 依赖版本管理
├── yudao-framework/          # 框架核心组件
├── yudao-gateway/            # API 网关
├── yudao-server/             # 主应用服务器
├── yudao-module-system/      # 系统管理模块
├── yudao-module-infra/       # 基础设施模块
├── yudao-module-bpm/         # 工作流引擎模块
├── yudao-module-oa/          # OA 协同办公模块
├── yudao-ui/                 # 前端项目
│   ├── yudao-ui-admin-vben/  # Vben Admin 前端
│   └── ...
├── sql/                      # 数据库脚本
└── docs/                     # 文档
```

### 常见问题

**Q: 如何添加新的业务模块？**
A: 参考现有的 `yudao-module-oa` 模块结构：
1. 创建新的模块目录
2. 在 pom.xml 中添加 module 引用
3. 在 yudao-server 中添加依赖
4. 创建对应的数据库表

**Q: 如何修改数据库连接？**
A: 修改 `yudao-server/src/main/resources/application.yml` 中的数据库配置

**Q: 单体模式和微服务模式的区别？**
A: 
- 单体模式：所有模块打在一个 jar 包中，启动一个进程
- 微服务模式：各模块独立部署，通过网关和 Nacos 进行通信

## 📖 参考资源

- [完整版 RuoYi Office](https://github.com/yuqing2026/ruoyi-office)
- [Spring Cloud 官方文档](https://spring.io/projects/spring-cloud)
- [Flowable 工作流文档](https://www.flowable.org/)
- [MyBatis Plus 文档](https://baomidou.com/)

## 📄 许可证

本项目采用 [MIT License](LICENSE) 开源协议，个人与企业可 100% 免费使用。

---

**🏢 RuoYi Office 简化版 - 让 OA 协同办公更简单**
