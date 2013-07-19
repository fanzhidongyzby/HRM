<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page contentType="image/jpeg" import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*,java.text.DecimalFormat" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>离退人员统计</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);   
    
    //获取参数
    String args="";
    if(request.getParameter("args")!=null)
    	args=request.getParameter("args");
    StringTokenizer token=new StringTokenizer(args,"-");
    int i=0;
    int sum=0;
    float per[]=new float[4];
    while(token.hasMoreTokens())
    {	
    	per[i]=Integer.parseInt(token.nextToken());
		sum+=per[i];		
		i++;
    }
    for(i=0;i<per.length;i++)//求出百分比
    {
    	if(sum!=0)
    	   	per[i]/=sum;
    	else
    		per[i]=0;
    }
    Color colors[]=new Color[]{new Color(200,0,0),new Color(128,128,64),new Color(0,128,128),new Color(128,128,255)};
 
    int width=200; //定义验证码图片的长度
    int height=200; //定义验证码图片的宽度
    BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB); 
    Graphics g = image.getGraphics();
	//开始
	//设置背景
	g.setColor(Color.white);
    g.fillRect(0, 0, width, height);
	int centerX=width/2;
	int centerY=height/2-25;
	int r=70;
	g.setColor(Color.LIGHT_GRAY);
	g.fillOval(centerX-r,centerY-r,2*r,2*r);
	float angle=0;
	for(i=0;i<per.length;i++)
	{
		g.setColor(colors[i]);
		g.fillArc(centerX-r,centerY-r,2*r,2*r,(int)angle,(int)(per[i]*360));
		angle+=per[i]*360;
	}
	g.setFont(new Font("隶书",Font.ITALIC,15));
	g.setColor(Color.black);
	g.drawLine(0,180,200,180);
	
	DecimalFormat df = new DecimalFormat("0.00");
	
	g.setColor(colors[0]);
	g.fillRect(20,165,10,15);
	g.drawString("退休",10,195);
	
	g.setColor(colors[1]);
	g.fillRect(70,165,10,15);
	g.drawString("辞职",60,195);
	
	
	g.setColor(colors[2]);
	g.fillRect(120,165,10,15);
	g.drawString("解雇",110,195);
	
	
	g.setColor(colors[3]);
	g.fillRect(170,165,10,15);
	g.drawString("意外",160,195);
	
	g.setFont(new Font("隶书",Font.ITALIC,12));
	g.setColor(Color.black);
	g.drawString(df.format(per[0]*100)+"%",5,160);
	g.drawString(df.format(per[1]*100)+"%",55,160);
	g.drawString(df.format(per[2]*100)+"%",105,160);
	g.drawString(df.format(per[3]*100)+"%",155,160);
	

    
    
    
    //结束
    g.dispose();   
    ImageIO.write(image, "JPEG", response.getOutputStream());
    //输出验证图片
    out.clear();
    out=pageContext.pushBody();  
%>
  </body>
</html>
