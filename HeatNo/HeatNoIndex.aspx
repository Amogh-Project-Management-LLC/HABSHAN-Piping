<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HeatNoIndex.aspx.cs" Inherits="HeatNo_HeatNoIndex" Title="Heat Numbers" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnMTC" runat="server" Text="MTC" Width="80" OnClick="btnMTC_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRecvd" runat="server" Text="Received" Width="80" OnClick="btnRecvd_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnESD" runat="server" Text="ESD" Width="80" OnClick="btnESD_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnJoints" runat="server" Text="Joints" Width="80" OnClick="btnJoints_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnBOM" runat="server" Text="BOM" Width="80" OnClick="btnBOM_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtFilter" runat="server" Width="150px" AutoPostBack="True" OnTextChanged="txtFilter_TextChanged" EmptyMessage="Search Here">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadDropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="120px">
                    </telerik:RadDropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="HeatNoGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="HeatNoDataSource" PageSize="12" SkinID="GridViewSkin"
            OnDataBound="HeatNoGridView_DataBound" OnRowEditing="HeatNoGridView_RowEditing"
            OnPageIndexChanged="HeatNoGridView_PageIndexChanged" DataKeyNames="HEAT_NO" Width="600px">
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView DataKeyNames="HEAT_NO">
                <Columns>                   
                    <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat No" ReadOnly="True" SortExpression="HEAT_NO"></telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="HeatNoDataSource" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGeneralTableAdapters.VIEW_ADAPTER_HNTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtFilter" Name="HEAT_NO" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
