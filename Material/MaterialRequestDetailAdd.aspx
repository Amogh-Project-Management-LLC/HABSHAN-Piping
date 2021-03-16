<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialRequestDetailAdd.aspx.cs" Inherits="Material_MaterialRequestDetailAdd" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
           width:120px;
           background-color:whitesmoke;
           padding-left:5px;
        }
    </style>
     <table class="auto-style1">

         <tr>
            <td class="Heading">Item Code</td>
            <td>:</td>
            <td> 
                <telerik:RadAutoCompleteBox ID="txtAutoCompltMatList" runat="server" DataSourceID="sqlMatSource" DataTextField="MAT_CODE1" DataValueField="MAT_ID" EmptyMessage="Enter Material Code...." InputType="Text"></telerik:RadAutoCompleteBox>
            </td>
        </tr>        
         <tr>
            <td class="Heading">Required Qty</td>
            <td>:</td>
            <td>
                  <asp:TextBox ID="txtReqQty" runat="server" Width="100px"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtReqQty"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>              
            </td>
        </tr>
         <tr>
            <td class="Heading">Required Date</td>
            <td>:</td>
            <td>               
                <telerik:RadDatePicker ID="txtReqDate" runat="server">
                     <Calendar ID="Calendar1" runat="server">
                      <SpecialDays>
                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Bisque" />
                      </SpecialDays>
                    </Calendar> 
                </telerik:RadDatePicker>   
                
                  <asp:RequiredFieldValidator ID="ReqDateValidator" runat="server" ControlToValidate="txtReqDate"
                                        ErrorMessage="*"></asp:RequiredFieldValidator> 
            </td>
        </tr>
         <tr>
            <td class="Heading">Required at Location</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtRqrdAtLocation"  runat="server"   Width="200px" >
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Remarks</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtRemarks"  runat="server"   Width="450px" >
                </telerik:RadTextBox>
            </td>
        </tr>
         <tr>
            <td >&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                <telerik:RadButton ID="btnSubmit" runat="server" CssClass="btnSubmit" Text="Submit" OnClick="btnSubmit_Click">
                </telerik:RadButton>
            </td>
        </tr>      
    </table>
    <asp:SqlDataSource ID="sqlMatSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1
FROM VIEW_STOCK
WHERE PROJ_ID = :PROJ_ID">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

