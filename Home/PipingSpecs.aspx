<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PipingSpecs.aspx.cs" Inherits="WeldingInspec_PipingSpecs" Title="Piping Specs" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <table style="width: 100%; background-color: gainsboro">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox EmptyMessage="Search.." ID="txtFilter" runat="server" AutoPostBack="True"
                        OnTextChanged="txtFilter_TextChanged" Width="200px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="PipingSpecGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="PipingSpecDataSource" SkinID="GridViewSkin"
            PageSize="13" Width="100%" OnDataBound="PipingSpecGridView_DataBound">
            <MasterTableView>
                <Columns>                   
                    <%--    <asp:BoundField DataField="WELD_GROUP" HeaderText="Weld Group" SortExpression="WELD_GROUP" />--%>
                    <telerik:GridBoundColumn DataField="PIPING_CLASS" HeaderText="Piping Class" SortExpression="PIPING_CLASS" />
                    <telerik:GridBoundColumn DataField="SRV_CODE" HeaderText="Service Code" SortExpression="SRV_CODE" />
                    <telerik:GridBoundColumn DataField="SRV_DESCR" HeaderText="Service Description" SortExpression="SRV_DESCR" />
                    <telerik:GridBoundColumn DataField="MATERIAL" HeaderText="Material" SortExpression="MATERIAL" />
                    <%--   <asp:BoundField DataField="SIZE_THICK_DESC" HeaderText="Size" SortExpression="SIZE_THICK_DESC" />--%>
                    <telerik:GridBoundColumn DataField="PWHT" HeaderText="PWHT" SortExpression="PWHT"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PWHT_ATTACH" HeaderText="PWHT (Attch)" SortExpression="PWHT_ATTACH" />
                    <telerik:GridBoundColumn DataField="VISUAL" HeaderText="Visual" SortExpression="VISUAL" />
                    <telerik:GridBoundColumn DataField="RT" HeaderText="RT" SortExpression="RT" />
                    <telerik:GridBoundColumn DataField="UT" HeaderText="UT" SortExpression="UT" />
                    <telerik:GridBoundColumn DataField="PT" HeaderText="PT" SortExpression="PT" />
                    <telerik:GridBoundColumn DataField="MT" HeaderText="MT" SortExpression="MT" />
                    <telerik:GridBoundColumn DataField="PMI_YN" HeaderText="PMI" SortExpression="PMI_YN" />
                    <telerik:GridBoundColumn DataField="HARDNESS" HeaderText="Hardness" SortExpression="HARDNESS" />
                    <telerik:GridBoundColumn DataField="NDE_CLASS" HeaderText="NDE Class" SortExpression="NDE_CLASS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="PipingSpecDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsGeneralTableAdapters.VIEW_PIPING_SPECSTableAdapter" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />   
            <asp:ControlParameter ControlID="txtFilter" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
