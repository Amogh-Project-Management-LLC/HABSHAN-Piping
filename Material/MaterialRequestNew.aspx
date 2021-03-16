<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialRequestNew.aspx.cs" Inherits="Material_MaterialRequestNew" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
         <table>
                <tr>
                    <td>Request Number</td>
                    <td>:</td>
                    <td>
                        <telerik:RadTextBox ID="txtRequestNo" runat="server" Width="200px">
                        </telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="reqNoValidator" runat="server" ControlToValidate="txtRequestNo"
                            ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Request Date</td>
                    <td>:</td>
                    <td>
                        <telerik:RadDatePicker ID="txtReqDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
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
                    <td>Requesting Subcon</td>
                    <td>:</td>
                    <td>
                        <telerik:RadDropDownList ID="ddFrom" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlFromSource" 
                            DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBinding="ddFrom_DataBinding" CausesValidation="false"
                            OnSelectedIndexChanged="ddFrom_SelectedIndexChanged"></telerik:RadDropDownList>
                        <telerik:RadLabel runat="server" Text="Who requests the material !"></telerik:RadLabel>
                    </td>
                </tr>
                <tr>
                    <td >Requested From</td>
                    <td >:</td>
                    <td>
                         <telerik:RadDropDownList ID="ddTo" runat="server" AppendDataBoundItems="True" DataSourceID="sqlToSource" DataTextField="SUB_CON_NAME" 
                              DataValueField="SUB_CON_ID" OnDataBinding="ddTo_DataBinding"></telerik:RadDropDownList>
                        <telerik:RadLabel runat="server" Text="From whom materials to be transfered!"></telerik:RadLabel>
                    </td>
                </tr>
              <tr>
                    <td >Created By</td>
                    <td >:</td>
                    <td>
                        <telerik:RadTextBox ID="txtReqBy" runat="server" Enabled="false">
                        </telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td >Remarks</td>
                    <td >:</td>
                    <td>
                        <telerik:RadTextBox ID="txtRemarks" runat="server" Width="455px">
                        </telerik:RadTextBox>
                    </td>
                </tr>

                <tr>
                    <td >&nbsp;</td>
                    <td >&nbsp;</td>
                    <td>
                        <telerik:RadButton ID="btnSubmit" runat="server" CssClass="btnSubmit" Text="Submit" OnClick="btnSubmit_Click">
                        </telerik:RadButton>
                    </td>
                </tr>
            </table>
    </div>
    <asp:SqlDataSource ID="sqlFromSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME
FROM SUB_CONTRACTOR
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlToSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME
FROM SUB_CONTRACTOR
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>  
</asp:Content>

