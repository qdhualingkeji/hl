// JavaScript Document
// JavaScript Document

document.getElementsByClassName = function(className, tagName){
	var elems = document.body.getElementsByTagName("*");
	if( tagName != null ) elems = document.body.getElementsByTagName(tagName);
	var result=[];
	for (i=0; j=elems[i]; i++){
	  if ((" "+j.className+" ").indexOf(" "+className+" ")!=-1){
	   result.push(j);
	  }
	}
	return result;
}

//=====================错误提示==================
function sAlert(bgDiv,msgDiv){
document.write("<bgsound src='../icons/online.wav' loop='0'>")
var msgw,msgh,bordercolor;
var sWidth,sHeight,widthpercenter;
sWidth=document.body.offsetWidth;
widthpercenter= (sWidth-403)/sWidth*50 + "%"
sHeight=document.body.scrollHeight;//屏幕高度（垂直分辨率）

document.getElementById("bgDiv").setAttribute('id','bgDiv');
document.getElementById("bgDiv").style.position="absolute";
document.getElementById("bgDiv").style.top="0";
document.getElementById("bgDiv").style.filter="progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=20,finishOpacity=20";
//document.getElementById("bgDiv").style.opacity="0.6";
document.getElementById("bgDiv").style.left="0";
document.getElementById("bgDiv").style.width="100%";
document.getElementById("bgDiv").style.height=sHeight + "px";
document.getElementById("bgDiv").style.zIndex = "10000";



document.getElementById("msgDiv").style.position = "absolute";
document.getElementById("msgDiv").style.left = widthpercenter;
document.getElementById("msgDiv").style.top = "30%";
document.getElementById("msgDiv").style.font="12px/1.6em Verdana, Geneva, Arial, Helvetica, sans-serif";
//document.getElementById("msgDiv").style.marginLeft = "-225px" ;
//document.getElementById("msgDiv").style.marginTop = -300+document.documentElement.scrollTop+"px";
document.getElementById("msgDiv").style.zIndex = "10001";

document.getElementById("bgDiv").style.display='block'
document.getElementById("msgDiv").style.display='block'
}
function removeObj(){//点击标题栏触发的事件
				document.getElementById("bgDiv").style.display='none'
				document.getElementById("msgDiv").style.display='none'
}

//函数：添加页面载入事件
function load_add(func){
	var tmp_event = window.onload;
	try{
		if(typeof (tmp_event) != 'function'){
			window.onload = function(){
				func();
			}
		}else{
			window.onload = function(){
				tmp_event();
				func();
			}
		}
	}catch(e){}
}

//常用函数重命名
function $(obj){return document.getElementById(obj);}
function $$(obj){return document.getElementsByName(obj);}
function $$$(obj){return document.getElementsByTagName(obj);}
function $$$$(obj,tag){return document.getElementsByClassName(obj,tag);}

load_add(page_load_menu);//载入系统链接
load_add(load_listline);//载入系统列表行
load_add(load_input);//载入输入框样式
//load_add(load_img_cmd);//载入小图标样式


function selectDataBase(value){
	if (value==0){view("accdate");hide("sqldate")}
	if (value==1){hide("accdate");view("sqldate")}
}

function selectLinkType(value){
	if (value==0){hide("imglink")}
	if (value==1){view("imglink")}
}

function page_load_menu(){
	var buttons = $$$$("btn","input");
	for( var i=0; i<buttons.length; i++ ){
		buttons[i].onmouseover = function(){this.className = "btn1";};
		buttons[i].onmouseout  = function(){this.className = "btn";};
		buttons[i].onfocus = function(){this.blur();};
	}
}

//函数：输入框样式
function load_input(){
	var lines = $$$("input");
	for( var i=0; i<lines.length; i++ ){
		if(lines[i].type=="text" || lines[i].type=="password")
		{
			lines[i].className = "ipt_text"
			lines[i].onfocus = function(){
				this.className="ipt_text_onfocus";
				if($(this.name+"Tip")){
					$(this.name+"Tip").className="TipOn";
				}
			}
			lines[i].onblur	=function(){
				this.className="ipt_text";
				if($(this.name+"Tip")){
					$(this.name+"Tip").className="";
				}
			}
			
		}
	}
	var textarea = $$$("textarea");
	
	for( var i=0; i<textarea.length; i++ ){
		textarea[i].className = "textarea_text"
		textarea[i].onfocus = function(){
			this.className="textarea_text_onfocus";
			if($(this.name+"Tip")){
				$(this.name+"Tip").className="TipOn";
			}
		};
		textarea[i].onblur	=function(){
			this.className="textarea_text";
			if($(this.name+"Tip")){
				$(this.name+"Tip").className="";
			}
		}
	}
}

//函数：系统列表行特效
function load_listline(){
	var lines = $$$$("list_line_Off","tr");
	for( var i=0; i<lines.length; i++ ){
		lines[i].onmouseover = function(){this.className = "list_line_On";};
		lines[i].onmouseout  = function(){this.className = "list_line_Off";};
	}
}