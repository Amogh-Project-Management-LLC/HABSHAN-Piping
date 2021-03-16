<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FitupWelding_BackLog.aspx.cs" Inherits="BasicReports_Welding_FitupWelding_BackLog" Title="Fitup Welding Backlog" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreviewFitup" runat="server" Text="Fitup Back Log" Width="110" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreviewWelding" runat="server" Text="Welding Back Log" Width="140px" OnClick="btnPreview1_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <table>
        <tr>
            <td style="width: 140px; background-color: gainsboro">Job Card Number
            </td>
            <td>
                <telerik:RadTextBox ID="txtSearchJC" runat="server" AutoPostBack="true" OnTextChanged="txtSearchJC_TextChanged" Width="200px"></telerik:RadTextBox>
            </td>
            <td>
                <telerik:RadDropDownList ID="cboJC" runat="server" AppendDataBoundItems="True" DataSourceID="jobCardDataSource"
                    DataTextField="WO_NAME" DataValueField="WO_ID" Width="298px">
                    <Items>
                        <telerik:DropDownListItem  Selected="True" Value="-1" Text="(All Job Cards)" />
                    </Items>
                </telerik:RadDropDownList>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="jobCardDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WO_ID, WO_NAME FROM PIP_WORK_ORD WHERE (PROJ_ID = :PROJECT_ID) AND (WO_NAME LIKE FNC_FILTER(:SEARCH)) ORDER BY WO_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtSearchJC" DefaultValue="%" Name="SEARCH" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>