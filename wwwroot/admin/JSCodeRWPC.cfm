<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<script language="javascript">
function SetDetailToOrder()
{
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-1].disabled = false;
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-2].disabled = false;
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-3].disabled = false;
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-4].disabled = false;
	document.FCustomers.ChartStyle[document.FCustomers.ChartStyle.length-1].disabled = false;
	document.FCustomers.ChartStyle[document.FCustomers.ChartStyle.length-2].disabled = false;
	document.FCustomers.ChartStyle[document.FCustomers.ChartStyle.length-3].disabled = false;
}

function SetDetailToCustomer()
{
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-1].disabled = true;
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-2].disabled = true;
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-3].disabled = true;
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-4].disabled = true;
	document.FCustomers.ChartStyle[document.FCustomers.ChartStyle.length-1].disabled = true;
	document.FCustomers.ChartStyle[document.FCustomers.ChartStyle.length-2].disabled = true;
	document.FCustomers.ChartStyle[document.FCustomers.ChartStyle.length-3].disabled = true;
}

function SetDetailToPhone()
{
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-1].disabled = true;
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-2].disabled = true;
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-3].disabled = true;
	document.FCustomers.ChartType[document.FCustomers.ChartType.length-4].disabled = true;
	document.FCustomers.ChartStyle[document.FCustomers.ChartStyle.length-1].disabled = true;
	document.FCustomers.ChartStyle[document.FCustomers.ChartStyle.length-2].disabled = true;
	document.FCustomers.ChartStyle[document.FCustomers.ChartStyle.length-3].disabled = true;
}

function SearchByAll()
{
	// ENABLE ALL
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-4].checked = true;
	// DISABLE TYPE
	document.FCustomers.UserOption[document.FCustomers.UserOption.length-1].disabled = true;
	document.FCustomers.UserOption[document.FCustomers.UserOption.length-2].disabled = true;
	document.FCustomers.SelectedUser.disabled = true;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-3].checked = false;
	// DISABLE REGION
	document.FCustomers.RegionOption[document.FCustomers.RegionOption.length-1].disabled = true;
	document.FCustomers.RegionOption[document.FCustomers.RegionOption.length-2].disabled = true;
	document.FCustomers.SelectedRegion.disabled = true;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-2].checked = false;
	// DISABLE DATE
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-1].disabled = true;
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-2].disabled = true;
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-3].disabled = true;
	document.FCustomers.FromDate.disabled = true;
	document.FCustomers.ToDate.disabled = true;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-1].checked = false;
}

function SearchByUser()
{
	// DISABLE ALL
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-4].checked = false;
	// ENABLE TYPE
	document.FCustomers.UserOption[document.FCustomers.UserOption.length-1].disabled = false;
	document.FCustomers.UserOption[document.FCustomers.UserOption.length-2].disabled = false;
	document.FCustomers.SelectedUser.disabled = false;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-3].checked = true;
	// DISABLE REGION
	document.FCustomers.RegionOption[document.FCustomers.RegionOption.length-1].disabled = true;
	document.FCustomers.RegionOption[document.FCustomers.RegionOption.length-2].disabled = true;
	document.FCustomers.SelectedRegion.disabled = true;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-2].checked = false;
	// DISABLE DATE
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-1].disabled = true;
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-2].disabled = true;
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-3].disabled = true;
	document.FCustomers.FromDate.disabled = true;
	document.FCustomers.ToDate.disabled = true;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-1].checked = false;
}

function SearchByRegion()
{
	// DISABLE ALL
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-4].checked = false;
	// DISABLE TYPE
	document.FCustomers.UserOption[document.FCustomers.UserOption.length-1].disabled = true;
	document.FCustomers.UserOption[document.FCustomers.UserOption.length-2].disabled = true;
	document.FCustomers.SelectedUser.disabled = true;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-3].checked = false;
	// ENABLE REGION
	document.FCustomers.RegionOption[document.FCustomers.RegionOption.length-1].disabled = false;
	document.FCustomers.RegionOption[document.FCustomers.RegionOption.length-2].disabled = false;
	document.FCustomers.SelectedRegion.disabled = false;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-2].checked = true;
	// DISABLE DATE
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-1].disabled = true;
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-2].disabled = true;
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-3].disabled = true;
	document.FCustomers.FromDate.disabled = true;
	document.FCustomers.ToDate.disabled = true;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-1].checked = false;
}

function SearchByDate()
{
	// DISABLE ALL
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-4].checked = false;
	// DISABLE TYPE
	document.FCustomers.UserOption[document.FCustomers.UserOption.length-1].disabled = true;
	document.FCustomers.UserOption[document.FCustomers.UserOption.length-2].disabled = true;
	document.FCustomers.SelectedUser.disabled = true;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-3].checked = false;
	// DISABLE REGION
	document.FCustomers.RegionOption[document.FCustomers.RegionOption.length-1].disabled = true;
	document.FCustomers.RegionOption[document.FCustomers.RegionOption.length-2].disabled = true;
	document.FCustomers.SelectedRegion.disabled = true;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-2].checked = false;
	// ENABLE DATE
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-1].disabled = false;
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-2].disabled = false;
	document.FCustomers.DateOption[document.FCustomers.DateOption.length-3].disabled = false;
	document.FCustomers.FromDate.disabled = false;
	document.FCustomers.ToDate.disabled = false;
	document.FCustomers.ReportType[document.FCustomers.ReportType.length-1].checked = true;
}

</script>