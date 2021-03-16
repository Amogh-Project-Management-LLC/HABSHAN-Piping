<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SpoolCoatingReport.aspx.cs" Inherits="SpoolMove_SpoolCoatingReport" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .heading {
            width: 150px;
            background-color: whitesmoke;
            padding-left: 5px;
        }
    </style>
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <div>
                <table>
                    <tr>
                        <td class="heading">Sub Contractor</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlSubcon" runat="server" AutoPostBack="True" DataSourceID="sqlSubcon"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" AppendDataBoundItems="True"
                                OnDataBinding="ddlSubcon_DataBinding" Width="200px">
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="heading">Coating Report Type</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlCoatingTypeList" runat="server" AutoPostBack="True" DataSourceID="sqlCoatingType"
                                DataTextField="COATING_TYPE" DataValueField="COATING_TYPE_ID" AppendDataBoundItems="true"
                                OnDataBinding="ddlCoatingTypeList_DataBinding" Width="200px">
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="heading">Isometric</td>
                        <td>
                            <telerik:RadSearchBox ID="txtSearchIsome" runat="server" Width="200px" DataSourceID="sqlIsomeSource" DataTextField="ISO_TITLE1" DataValueField="ISO_TITLE1" 
                                EmptyMessage="Search Isometric..." OnSearch="txtSearchIsome_Search"></telerik:RadSearchBox>
                        </td>
                        <td colspan="2">
                            <telerik:RadComboBox ID="cboSpoolList" runat="server" DataSourceID="sqlSpoolSource" DataTextField="SPOOL" 
                                DataValueField="SPL_ID" CheckBoxes="True" EnableCheckAllItemsCheckBox="true"></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="heading">Coating Report No</td>
                        <td>
                            <telerik:RadTextBox ID="txtCoatingRep" runat="server" Width="150px"></telerik:RadTextBox>
                        </td>
                        <td class="heading">Blasting Report No</td>
                        <td>
                            <telerik:RadTextBox ID="txtBlastRep" runat="server" Width="150px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="heading">Coating Report Date</td>
                        <td>
                            <telerik:RadDatePicker ID="txtCoatingDate" runat="server"></telerik:RadDatePicker>
                        </td>
                        <td class="heading">Blasting Date</td>
                        <td>
                            <telerik:RadDatePicker ID="txtBlastDate" runat="server"></telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="sqlCoatingType" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM PIP_COATING_TYPE"></asp:SqlDataSource>
            <asp:HiddenField ID="HiddenIsometric" runat="server" />
            <asp:SqlDataSource ID="sqlIsomeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT ISO_TITLE1
FROM VIEW_SPL_COATING_REPORT
WHERE COAT_REP_DT IS NULL AND TYPE_ID = :TYPE_ID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlCoatingTypeList" DefaultValue="-1" Name="TYPE_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlSpoolSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SPL_ID, SPOOL
FROM VIEW_SPL_COATING_REPORT
WHERE ISO_ID = :ISO_ID AND TYPE_ID = :TYPE_ID AND COAT_REP_DT IS NULL ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenISO" DefaultValue="-1" Name="ISO_ID" PropertyName="Value" />
                    <asp:ControlParameter ControlID="ddlCoatingTypeList" DefaultValue="-1" Name="TYPE_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenISO" runat="server" />
            <asp:SqlDataSource ID="sqlSubcon" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM SUB_CONTRACTOR
WHERE PAINT_SC = 'Y'"></asp:SqlDataSource>
       <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>

</asp:Content>

