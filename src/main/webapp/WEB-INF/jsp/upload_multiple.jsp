<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="${pageContext.request.contextPath }/plugins/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/cropper.min.css" />
<title>上传图片</title>

<style>
	.container {
      max-width: 640px;
      margin: 20px auto;
      margin-bottom: 10px;
      border:solid 1px #e4e6e8;
      padding:5px;
    }

    img {
      width: 100%;
    }
    .row{
         margin-right: 0px; }
    .col-xs-2{
    	margin-left:10px;
    }
</style>
</head>
<body>
<form method="post" enctype="multipart/form-data">
	<c:if test="${data.size()>0}">
		<c:forEach var="resource" items="${data}" varStatus="i">
			<div class="container" id="exits_${i.index }">
				<div class="center-block">
					<img class="img-responsive center-block" src="${resource.img }" alt="Picture" id="exits_${i.index }" index="${i.index }">
					<input type="hidden" value="${resource.img }" name="${resource.id}"/>
				</div>
				<div class="row pull-right" style="margin-top: 10px;">
					<div class="col-xs-2">
						<input type="button" class="btn btn btn-info btn-sm del-img" data="${resource.id}" value="删除图片"/>
					</div>
					<div class="col-xs-2">
						<input type="button" class="btn btn btn-warning btn-sm rotate-left" value="向左旋转"/>
					</div>
					<div class="col-xs-2">
						<input type="button" class="btn btn btn-danger btn-sm rotate-right" value="向右旋转"/>
					</div>
					<div class="col-xs-2">
						<input type="button" class="btn btn btn-primary btn-sm cancel-fix" style="color: #fff;background-color: #b10295;border-color: #b10295;" value="取消裁剪"/>
					</div>
					<div class="col-xs-2">
						<input type="button" class="btn btn btn-info btn-sm get-img" value="确认裁剪"/>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>
	<c:if test="${count-data.size()>0}">
		<c:forEach var="resource" begin="0" end="${count-data.size()-1}" step="1" varStatus="i">
				<div class="container" id="container_${i.index }">
					<div class="center-block">
						<img class="img-responsive center-block" index="${data.size()+i.index}" id="img_${data.size()+i.index}" src="${pageContext.request.contextPath }/imgs/63d9f2d3572c11df5243a9eb692762d0f603c26c.jpg" is_new='true'/>
						<input type="hidden" value="" name="img_${data.size()+i.index}" id="img_${data.size()+i.index  }"/>
					</div>
					<div class="row pull-right" style="margin-top: 10px;">
						<div class="col-xs-2">
						<input type="button" class="btn btn-success btn-sm choise-img" value="选择图片"/>
					</div>
					<div class="col-xs-2">
						<input type="button" class="btn btn btn-warning btn-sm rotate-left" value="向左旋转"/>
					</div>
					<div class="col-xs-2">
						<input type="button" class="btn btn btn-danger btn-sm rotate-right" value="向右旋转"/>
					</div>
					<div class="col-xs-2">
						<input type="button" class="btn btn btn-primary btn-sm cancel-fix" style="color: #fff;background-color: #b10295;border-color: #b10295;" value="取消裁剪"/>
					</div>
					<div class="col-xs-2">
						<input type="button" class="btn btn btn-info btn-sm get-img" value="确认裁剪"/>
					</div>
					</div>
				</div>
		</c:forEach>
	</c:if>
</form>
	<nav class="navbar navbar-default navbar-fixed-bottom" style="position: fixed;background: rgb(248,248,248);">
		<div class="pull-right">
			<div  style="text-align: center;margin-top: 5px;margin-right: 10px">
				<input id="cancel" type="button" class="btn btn-danger" value="退出编辑">
				<input id="save" type="button" class="btn btn-primary" value="提交保存">
			</div>
		</div>
</nav>
    <!-- 文件选择框，将其透明度设置为0，全透明，然后设置其位置为固定位置，在页面上方鼠标够不着也点不到的地方 -->
	<input type="file" multiple="multiple" style="opacity: 0;margin-top: 50px;position: fixed;top: -10000000px;" id="file" />
	<!-- Scripts -->
	<script src="${pageContext.request.contextPath }/js/jquery-3.2.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/js/cropper.min.js"></script>
	<script src="${ pageContext.request.contextPath}/plugins/layui/layui.js"></script>
	<script>
	var options = {
	        aspectRatio: 16 / 9,
	        preview: '.img-preview',
	        crop: function (e) {
	         	console.log(e);
	        }
	};//cancel-fix
	var layer=null;
	var count='${count}';
	layui.use(['layer'],function(){
		layer=layui.layer;
	});
	$('.cancel-fix').click(function(e){
		//销毁cropper编辑器
		$(this).parents('.container').find('img:eq(0)').cropper('destroy');
	});
	$('.rotate-left').click(function(e){
		//向左旋转图片2 弧度，嗯，是弧度
		$(this).parents('.container').find('img:eq(0)').cropper('rotate',2);
	   });
	   
    $('.rotate-right').click(function(e){
    	//向右旋转图片2 弧度
    	$(this).parents('.container').find('img:eq(0)').cropper('rotate',-2);
    });
    
    $('.get-img').click(function(){
		var d=$(this).parents('.container').find('img:eq(0)').cropper('getCroppedCanvas',{'maxWidth':4096,'maxHeight':4096});
		var s=d.toDataURL('image/png',0.8);
		$(this).parents('.container').find('img:eq(0)').cropper('destroy');
		$(this).parents('.container').find('img:eq(0)').attr('src',s);
		$(this).parents('.container').find('img:eq(0)').next().val(s);
	});
    $('.del-img').click(function(){
    	//删除图片
    	var id=$(this).attr('data');
    	//获取当前父容器，ajax成功删除之后移除该节点
    	var thisParentContainer=$(this).parents('.container');
    	//获取父容器数量，如果容器数量小于1个，那么刷新页面
    	var length=$('.container').length;
    	if(length<1){location.reload(true);return false;}
    	//ajax删除
    	$.getJSON('${pageContext.request.contextPath }/img/delete?type=${type }&gid=${gid}&sign=${sign}&id='+id,function(rs){
    		if(rs&&rs.delete_count&&rs.delete_count>0){
    			$(thisParentContainer).remove();
    			layer.msg('删除成功!');
    		}else{
    			layer.msg('删除失败!');
    		}
    	});
    });
    
	/*** 原理，当点击图片或者图片按钮时，为其图片添加selected属性，然后调用文件input的click事件，其次，当选择文件也就是文件input有change事件时调用fileReader读取数据，赋值给有selected属性值的img的src和img的兄弟节点的hidden input***/
	$('#file').change(function(e) {
		var files = $(this)[0].files;
		console.log(files);
		//H5新特性，FileReader，IE10以上,火狐谷歌欧鹏浏览器都支持了
		if (typeof (FileReader) != "undefined") {
			//获取选中的图片
			var imgStartIndex=$('img[seleced]').attr('index');
			//读取文件，从选定的容器向下，有多少张图片填多少张图片内容，当然选择的图片不够多就算了
			for(var i=0;i<files.length&&i<=count;i++){
				//必须放循环里面new，否则reader.onload报错
				var reader = new FileReader();
				reader.onload = function(e) {
					//读取一张图片完成,读取的内容为一串老长的base64字符串
					var img=$('img.img-responsive.center-block:eq('+imgStartIndex+')');
					var src = e.target.result
					//先销毁cropper编辑器
					$(img).cropper('destroy');
					//设置图片路径
					$(img).attr('src', src);
					//设置提交内容为图片的base64字符串
					$(img).parents('.container').find('input:hidden').val(src);
					//重新初始化cropper
					$(img).cropper(options);
					imgStartIndex++;
				}
				//调用读取的方法，真正的读取完成是在onload方法的回调开始时候
				reader.readAsDataURL(files[i]);
			}
		} else {
			//如果不支持FileReader，则禁用所有input按钮和其他input
			layer.alert("你的浏览器不支持FileReader,无法使用本页面的功能.");
			$('input').attr('disabled','disabled');
		}
	});

		$(function() {
			//初始化cropper
			$('img[is_new]').cropper(options);
			//最后一个容器底部的距离为50px;
			$('.container:last').css('margin-bottom','50px');
			//选择图片按钮事件
			$('.choise-img').click(
					function(e) {
						//为其容器内的img添加seleced标记
						$(this).parents('.container').find('img:eq(0)').attr(
								'seleced', 'seleced');
						$(this).parents('.container').siblings().each(
								//为其容器的兄弟容器内的img移除seleced标记
								function(i, e) {
									$(e).find('img:eq(0)').removeAttr('seleced');
								});
						//调用文件选择框的click事件，弹出文件选择框
						$('#file').click();
					});

			$('img').click(function(e) {
				//点击后为img节点加属性(标记)seleced，为其兄弟节点去掉seleced标记
				$(this).attr('seleced', 'seleced');
				$(this).parents('.container').siblings().each(function(i, e) {
					$(e).find('img:eq(0)').removeAttr('seleced');
				});
				//调用文件的click事件
				$('#file').click();
			})
			//退出编辑按钮点击事件，这里假设此页面是弹窗形式出现，弹窗主流就这两种，window.open和layer.open,自定义就不说了
			$('#cancel').click(function(e){
				if (parent&&parent.layer) {
					parent.layer.closeAll();
				}else {
					window.close();
				}
			});
			//保存按钮事件
			$('#save').click(function(e){
				//序列化表单
				var data=$('form:eq(0)').serialize();
				//post提交数据
				$.post('${pageContext.request.contextPath }/img/upload/base64?type=${type }&gid=${gid}&callback=${callback}&sign=${sign}',data,function(rs){
					if(rs){
						layer.msg('上传成功!');
					}else{
						layer.msg('上传失败，请稍后再试!');
					}
					setTimeout(function(){
						$('.layui-layer-setwin').click();
					},1500);
				},'json');
			});
		});
	</script>
</body>
</html>