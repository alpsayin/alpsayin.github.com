function showLastModified()
{
	var lastModifiedDate=new Date(document.lastModified);
	var milliseconds=lastModifiedDate.getTime()+(1000*60*60*3); //add 3 hours to UTC
	lastModifiedDate=new Date(milliseconds);
	document.getElementById("lastModifiedDiv").innerHTML=("<p>Last Modified:<br>"+lastModifiedDate+"</p>");
}