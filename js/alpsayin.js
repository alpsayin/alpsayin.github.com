// author: alp sayin

function showLastModified()
{
	var lastModifiedDate=new Date(document.lastModified);
	var milliseconds=lastModifiedDate.getTime()+(1000*60*60*2); //add 3 hours to UTC
	lastModifiedDate=new Date(milliseconds);
	document.getElementById("lastModifiedDiv").innerHTML=(""+lastModifiedDate+"");
}

function askForLeavingUniversityServer(outside_url)
{
	console.log('askForLeavingUniversityServer: '+outside_url)
	var sure = window.confirm("If you continue, you will be leaving University of Birmingham Servers. Are you sure?");
	if(sure)
	{
		window.open(outside_url,'_blank');
	}
}