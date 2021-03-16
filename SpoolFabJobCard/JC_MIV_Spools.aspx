<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="JC_MIV_Spools.aspx.cs" Inherits="Material_Reports_JC_MIV" Title="Jobcard MIV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntryMode" runat="server" Text="Add Spools" Width="100" OnClick="btnEntryMode_Click"></telerik:RadButton>
                </td>

            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" OnItemCommand="rowsGridView_ItemCommand"
            PageSize="30" Width="100%" DataKeyNames="ISSUE_ID,SPL_ID" DataSourceID="rowsDataSource" PagerStyle-AlwaysVisible="true" AllowFilteringByColumn="true">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataSourceID="rowsDataSource" DataKeyNames="ISSUE_ID,SPL_ID" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <HeaderStyle Width="50px" />
                        <ItemStyle Width="50px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmTextFormatString="Delete this Spool <br\> {0}?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" ConfirmTextFields="SPL_TITLE"
                        UniqueName="DeleteColumn">
                        <HeaderStyle Width="50px" />
                        <ItemStyle Width="50px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="SPL_TITLE" HeaderText="Isometric - Spool" ReadOnly="true" SortExpression="SPL_TITLE" AllowFiltering="true" AutoPostBackOnFilter="true">
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JC_NO" HeaderText="Jobcard No" ReadOnly="True" SortExpression="JC_NO">
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_AVL" HeaderText="Material Avl" ReadOnly="True" SortExpression="MAT_AVL" AllowFiltering="false">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_SIZE" HeaderText="Spool Size" ReadOnly="True" SortExpression="SPL_SIZE" AllowFiltering="false">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_TYPE" HeaderText="Material Type" ReadOnly="True" SortExpression="MAT_TYPE" AllowFiltering="false">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CLASS" HeaderText="Mat Class" ReadOnly="True" SortExpression="MAT_CLASS" AllowFiltering="false">
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WBS_AREA" HeaderText="WBS AREA" ReadOnly="True" SortExpression="WBS_AREA" AllowFiltering="false">
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS">
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div>
        <table style="width: 100%; background-color: whitesmoke">
            <tr>

                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtIsome" runat="server" AutoPostBack="True" Visible="False"
                        Width="200px" EmptyMessage="Isometric No">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="cboNewSpool" runat="server" DataSourceID="SpoolDataSource"
                        DataTextField="SPL_TITLE" DataValueField="SPL_ID" Visible="False" Width="250px">
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddSpool" runat="server" Text="Save" Width="80" OnClick="btnAddSpool_Click" Visible="False"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="rowsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsFabricationJCTableAdapters.PIP_MAT_ISSUE_WO_SPLTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="Original_SPL_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="Original_SPL_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ISSUE_ID" QueryStringField="ISSUE_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPL_TITLE FROM VIEW_TOTAL_SPOOL_LIST
WHERE ((PROJECT_ID = :PROJ_ID)
 AND (ISO_TITLE1 = :ISO_TITLE1)
AND (SPOOL &lt;&gt; 'EREC')
AND (SPL_ID IN (SELECT SPL_ID FROM PIP_WORK_ORD_SPOOL WHERE WO_ID=:WO_ID))
AND (SPL_ID NOT IN (SELECT SPL_ID FROM PIP_MAT_ISSUE_WO_SPL))
AND ((SPL_SWN_NO IS NULL) OR (SPL_SWN_NO IS NOT NULL AND SPL_REL_NO IS NOT NULL)))
ORDER BY SPL_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO_TITLE1" PropertyName="Text"
                Type="String" />
            <asp:QueryStringParameter DefaultValue="-1" Name="WO_ID" QueryStringField="WO_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
