<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Isome_Supp_List.aspx.cs" Inherits="Isome_Supp_List" Title="Isometric Support List" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">

        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBOM" runat="server" Text="Support BOM" Width="100px" OnClick="btnBOM_Click" Enabled="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnDetails" runat="server" Text="View" Width="90px" OnClick="btnDetails_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnUpdateFab" runat="server" Text="Fabrication" Width="100px" OnClick="btnUpdateFab_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                        EmptyMessage="Isometric No" Width="195px"
                        AutoPostBack="True">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSearchTag" runat="server"
                        EmptyMessage="Tag No" Width="195px"
                        AutoPostBack="True">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="tpGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataSourceID="rowsDataSource" Width="100%" DataKeyNames="BOM_ID" SkinID="GridViewSkin" PageSize="15" 
                    OnSelectedIndexChanged="tpGridView_SelectedIndexChanged" Font-Size="9pt">
                    <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                    <MasterTableView DataKeyNames="BOM_ID" AllowAutomaticUpdates="true">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>                            
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" />
                            <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                            <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" />
                            <telerik:GridBoundColumn DataField="SPL_JC_NO" HeaderText="Spool Job Card" SortExpression="SPL_JC_NO" />
                            <telerik:GridBoundColumn DataField="SUPP_JC_NO" HeaderText="Supp Job Card" SortExpression="SUPP_JC_NO" />
                            <telerik:GridBoundColumn DataField="MAT_TYPE" HeaderText="Material Type" SortExpression="MAT_TYPE" />
                            <telerik:GridBoundColumn DataField="MAT_CLASS" HeaderText="Mat Class" SortExpression="MAT_CLASS" />
                            <telerik:GridBoundColumn DataField="PT_NO" HeaderText="Iso Part No" SortExpression="PT_NO" />
                            <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Support Tag No" SortExpression="MAT_CODE1" />
                            <telerik:GridBoundColumn DataField="MAT_DESCR" HeaderText="Description" SortExpression="MAT_DESCR" />
                            <telerik:GridBoundColumn DataField="SF_FLG" HeaderText="S/F" SortExpression="SF_FLG" />
                            <telerik:GridBoundColumn DataField="NET_QTY" HeaderText="Total Qty" SortExpression="NET_QTY" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtSearch" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <asp:ObjectDataSource ID="rowsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsSupp_ATableAdapters.VIEW_BOM_SUPPTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" Name="ISO_TITLE1" PropertyName="Text" Type="String"
                DefaultValue="XYZ" />
            <asp:ControlParameter ControlID="txtSearchTag" DefaultValue="%" Name="MAT_CODE1" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
