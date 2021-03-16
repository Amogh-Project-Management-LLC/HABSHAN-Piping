<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CustomReportCreate.aspx.cs" Inherits="Home_Home" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">

* {
  box-sizing: border-box;
}

.input{
  width: 100%;
  min-width:300px;
  padding: 5px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 5px 5px 5px 0;
  display: inline-block;
  font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.submit {
  padding: 12px 20px;

  border-radius: 4px;
  cursor: pointer;
  float: right;
  margin-top:10px;
  margin-right:0px;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: ghostwhite;
  padding: 5px;
  width: 60%;
}

.col-25 {
  float: left;
  width: 25%;
  margin-top: 6px;
}

.col-75 {
  float: left;
  width: 75%;
  margin-top: 6px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

.header{
   text-align:center;
   border:1px;
   
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}



    </style>
   <%-- <div class="container">
        <table>
            <tr>
                <td>
                    <telerik:RadLabel ID="lable1" Text="Report Name" runat="server"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReportName" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadLabel ID="label2" Text="Report Code" runat="server"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReportCode" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadLabel ID="RadLabel1" Text="Report Group" runat="server"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReportGroup" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                  <td>
                    <telerik:RadLabel ID="RadLabel2" Text="Report Source" runat="server"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadComboBox ID="rcbReportsrc" DataSourceID="ReportDataSource" DataTextField="EXPT_TITLE" DataValueField="EXPT_ID" runat="server" AllowCustomText="true" Filter="Contains"></telerik:RadComboBox>
                </td>
            </tr>
        </table>
    </div>
--%>


    <div class="container">
        <div class="row">
    <div class="header">
      <h1 >
          New Custom Report
      </h1>
    </div>
  </div>
        <div class="row">
    <div class="col-25">
      <label>Report Code</label>
    </div>
    <div class="col-75">
         <telerik:RadTextBox ID="txtReportCode" runat="server" CssClass="input" Enabled="false" BackColor="Gainsboro"></telerik:RadTextBox>
    </div>
  </div>
  <div class="row">
    <div class="col-25">
      <label >Report Name</label>
    </div>
    <div class="col-75">
       <telerik:RadTextBox ID="txtReportName" runat="server" CssClass="input" ></telerik:RadTextBox>
    </div>
  </div>
  
  <div class="row">
    <div class="col-25">
      <label>Report Group</label>
    </div>
    <div class="col-75">
       <telerik:RadTextBox ID="txtReportGroup" runat="server" CssClass="input"></telerik:RadTextBox>
    </div>
  </div>
  <div class="row">
    <div class="col-25">
      <label>Report Source</label>
    </div>
    <div class="col-75">
         <telerik:RadComboBox ID="rcbReportsrc" DataSourceID="ReportDataSource" DataTextField="EXPT_TITLE" DataValueField="EXPT_ID"
             runat="server" AllowCustomText="true" Filter="Contains" CssClass="input"></telerik:RadComboBox>
    </div>
  </div>
         <div class="row">
  
    <div >
      <telerik:RadButton  ID="btnSave" runat="server" Text="Save & Proceed" OnClick="btnSave_Click" CssClass="submit"></telerik:RadButton>
    </div>
  </div>
</div>
    
    

     <asp:SqlDataSource ID="ReportDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM IPMS_SYS_EXPORT"></asp:SqlDataSource>
</asp:Content>

