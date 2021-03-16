<%@ Page Title="Material Request" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialRequest.aspx.cs" Inherits="Material_MaterialRequest" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=RadGrid1.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 180 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnRegisrer" runat="server" Text="Register" Width="90px"></telerik:RadButton>
        <telerik:RadButton ID="btnMaterial" runat="server" Text="Material" Width="90px" OnClick="btnMaterial_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="90px" OnClick="btnPreview_Click"></telerik:RadButton>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid DataSourceID="MatReq_GridView" ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
            AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" PageSize="30"
            AutoGenerateColumns="False" OnItemDataBound="RadGrid1_ItemDataBound" OnPreRender="RadGrid1_PreRender">
            <GroupingSettings CaseSensitive="False" />
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView DataSourceID="MatReq_GridView" DataKeyNames="MAT_REQ_ID" EditMode="InPlace">
                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                    <HeaderStyle Width="20px"></HeaderStyle>
                </RowIndicatorColumn>
                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                    <HeaderStyle Width="20px"></HeaderStyle>
                </ExpandCollapseColumn>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="20" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmTextFormatString="Are you sure you want to delete {0} ?" ConfirmTextFields="MAT_REQ_NO" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="20" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="MAT_REQ_NO" ReadOnly="true" FilterControlAltText="Filter MAT_REQ_NO column" HeaderText="MATERIAL REQUEST No." SortExpression="MAT_REQ_NO" UniqueName="MAT_REQ_NO" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn DataField="MAT_REQ_DATE" DataType="System.DateTime" FilterControlAltText="Filter MAT_REQ_DATE column" HeaderText="REQUEST DATE" SortExpression="MAT_REQ_DATE" UniqueName="MAT_REQ_DATE" DataFormatString="{0:dd-MMM-yyyy}" AllowFiltering="false">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" ReadOnly="true" DataField="FROM_SUBCON" FilterControlAltText="Filter FROM_SUBCON column" HeaderText="REQUEST FROM" SortExpression="FROM_SUBCON" UniqueName="FROM_SUBCON">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditFromSubcon" runat="server" DataSourceID="sqlFromSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                                SelectedValue='<%# Bind("REQ_FROM") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="FROM_SUBCONLabel" runat="server" Text='<%# Eval("FROM_SUBCON") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" ReadOnly="true" DataField="TO_SUBCON" FilterControlAltText="Filter TO_SUBCON column" HeaderText="REQUEST TO" SortExpression="TO_SUBCON" UniqueName="TO_SUBCON">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditToSubcon" runat="server" DataSourceID="sqlToSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                                SelectedValue='<%# Bind("REQ_TO") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="TO_SUBCONLabel" runat="server" Text='<%# Eval("TO_SUBCON") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REQ_BY" ReadOnly="true" FilterControlAltText="Filter REQ_BY column" HeaderText="REQUEST BY" SortExpression="REQ_BY" UniqueName="REQ_BY" AllowFiltering="False">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="False">
                        <ItemStyle HorizontalAlign="Left" />
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
            <FilterMenu EnableImageSprites="False"></FilterMenu>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource SelectMethod="GetData" UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery" TypeName="dsMaterialATableAdapters.VIEW_MATERIAL_REQUESTTableAdapter" ID="MatReq_GridView" runat="server" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" Type="Decimal" SessionField="PROJECT_ID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MAT_REQ_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_MAT_REQ_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_MAT_REQ_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <asp:HiddenField ID="FilterValue" runat="server" />
    <asp:SqlDataSource ID="sqlFromSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME
FROM SUB_CONTRACTOR
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlToSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME
FROM SUB_CONTRACTOR
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
</asp:Content>

