<!--#include file="AspCms_CompanyConfig.asp" -->
<!--#include file="AspCms_SeoConfig.asp" -->
<!--#include file="AspCms_TemplateConfig.asp" -->
<!--#include file="AspCms_CopyRightConfig.asp" -->
<!--#include file="AspCms_SlideConfig.asp" -->
<!--#include file="AspCms_ADConfig.asp" -->
<!--#include file="AspCms_OnlineServiceConfig.asp" -->
<%
Const sitePath=""  '网站目录 例如:cms/
Const accessFilePath="AspCms_data/data.asp"  'access数据库文件路径
Const htmlFilePath="html"  'html模板路径，防模板下载
Const FileExt=".html"	'生成文件扩展名（htm,html,asp）
Const databaseType=0  '数据库类型（0为access；1为sqlserver）
Const databaseServer="(local)"  'sqlserver数据库地址
Const databaseName="aspcms"  'sqlserver数据库名称
Const databaseUser="sa"  'sqlserver数据库账号
Const databasepwd="sa"  'sqlserver数据库密码
Const siteName=""  '站点名称
Const siteNotice=""		'网站公告（在网站关闭时显示）
'开关类
Const siteMode=1	'网站状态（0为关闭，1为运行）
Const SwitchFaq=0	'留言开关（0为关闭，1为正常）
Const SwitchFaqStatus=0	'留言审核开关（0为不启用，1为启用）
Const SwitchComments=0	'评论开关（0为关闭，1为开启）
Const SwitchCommentsStatus=0	'评论审核是否启用（0为不启用，1为启用）
Const SwitchBBS=0	'论坛开关（0为关闭，1为正常）
Const waterMark=0	'水印
Const waterMarkFont=""	'水印文字
Const waterMarkLocation=""	'位置
Const upLoadPath="upLoad"	'上传文件目录
Const textFilter=""	'脏话过滤
%>
