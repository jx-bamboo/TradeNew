# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



1.安装依赖
```
ruby '2.5.3'
gem install
```
2.配置config/redis.yml config/databases.yml. config/cable.yml里面的信息项
```
主要是一些数据库信息的配置，按要求配置即可
```
3.配置config/config.yml里面的信息项
```
http_url: http://127.0.0.1:3000  这个地址是通知web服务器导出数据成功的地址，修改成正确的web服务器地址即可
```
4.启动sidekiq
```
bundle exec sidekiq -d -e development -C config/sidekiq.yml
```
5.启动项目
```
puma -e production -p 4001
```
