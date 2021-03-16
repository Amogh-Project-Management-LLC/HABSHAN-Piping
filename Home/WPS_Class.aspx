<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="WPS_Class.aspx.cs" Inherits="Home_WPS_Class" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton Text="Add" runat="server" ID="btnAdd" Width="80px" OnClick="btnAdd_Click"></telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="background-color:whitesmoke; width:120px">Select Class</td>
                <td>
                     <telerik:RadComboBox ID="cboPipeClass" runat="server" AllowCustomText="True" CheckBoxes="True" DataSourceID="sqlPipingClass" DataTextField="PIPING_CLASS" DataValueField="PIPING_CLASS"></telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadButton Text="Save" runat="server" ID="btnSave" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="sqlClassSource" GridLines="None"
         AllowAutomaticDeletes="true" OnItemCommand="RadGrid1_ItemCommand" MasterTableView-DataKeyNames="CLASS"
         Width="350px">
        <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
        <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlClassSource" DataKeyNames="CLASS">
            <Columns>
                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                    <ItemStyle Width="20" />
                </telerik:GridButtonColumn>
                <telerik:GridBoundColumn DataField="CLASS" FilterControlAltText="Filter CLASS column" HeaderText="CLASS" SortExpression="CLASS" UniqueName="CLASS">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sqlClassSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT CLASS FROM PIP_WPS_SPEC WHERE WPS_ID = :WPS_ID ORDER BY CLASS">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WPS_ID" QueryStringField="WPS_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPipingClass" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PIPING_CLASS FROM PIPING_SPECS ORDER BY PIPING_CLASS"></asp:SqlDataSource>
</asp:Content>

