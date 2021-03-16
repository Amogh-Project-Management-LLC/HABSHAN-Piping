<%@ Page Title="Material Requisition" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MR.aspx.cs" Inherits="Material_MR" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=itemsGrid.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 180 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton runat="server" ID="btnAdd" Text="Add" Width="80px"></telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnItems" Text="Items" Width="80px" OnClick="btnItems_Click"></telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnExport" Text="Download" OnClick="btnExport_Click">
                        <Icon PrimaryIconUrl="../Images/icons/icon-save2.png" />
                    </telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnImport" Text="Import.." Width="100px">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnPOBal" runat="server" Text="PO Not Placed" Width="150px" OnClick="btnPOBal_Click">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>

                </td>
                <td>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="updatePanel1">
                        <ProgressTemplate>
                            <img src="../Images/ajax-loader-bar.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="200px" EmptyMessage="Search MR..." AutoPostBack="true"></telerik:RadTextBox>
                </td>
            </tr>
        </table>

    </div>

    <asp:UpdatePanel runat="server" ID="updatePanel1">
        <ContentTemplate>
            <div style="margin-top: 3px">
                <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"
                    AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" MasterTableView-EditMode="InPlace"
                    AllowPaging="True" PageSize="20">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="MR_ID" DataSourceID="itemsDataSource">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="40px" />
                                <HeaderStyle Width="40px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow"
                                ConfirmText="Are you sure you want to delete?" ConfirmTitle="Delete">
                                <ItemStyle Width="40px" />
                                <HeaderStyle Width="40px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="MR_NO" FilterControlAltText="Filter MR_NO column" HeaderText="MR NO" ReadOnly="False" SortExpression="MR_NO" UniqueName="MR_NO">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MR_REV" FilterControlAltText="Filter MR_REV column" HeaderText="REV NO" SortExpression="MR_REV" UniqueName="MR_REV">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MR_TITLE" FilterControlAltText="Filter MR_TITLE column" HeaderText="MR TITLE" SortExpression="MR_TITLE" UniqueName="MR_TITLE" HeaderStyle-Width="200px" ItemStyle-Width="200px">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DISCIPLINE_CODE" FilterControlAltText="Filter DISCIPLINE_CODE column" HeaderText="DISCIPLINE CODE" SortExpression="DISCIPLINE_CODE" UniqueName="DISCIPLINE_CODE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="STATUS" FilterControlAltText="Filter STATUS column" HeaderText="STATUS" SortExpression="STATUS" UniqueName="STATUS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CREATE_DATE" ReadOnly="true" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column" HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>


    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialDTableAdapters.PIP_MAT_REQUISITIONTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_MR_ID" Type="Decimal" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PROJECT_ID" Type="Decimal" />
            <asp:Parameter Name="MR_ID" Type="Decimal" />
            <asp:Parameter Name="MR_NO" Type="String" />
            <asp:Parameter Name="MR_REV" Type="String" />
            <asp:Parameter Name="MR_TITLE" Type="String" />
            <asp:Parameter Name="DISCIPLINE_CODE" Type="String" />
            <asp:Parameter Name="STATUS" Type="String" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="CREATE_BY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MR_NO" Type="String" />
            <asp:Parameter Name="MR_REV" Type="String" />
            <asp:Parameter Name="MR_TITLE" Type="String" />
            <asp:Parameter Name="DISCIPLINE_CODE" Type="String" />
            <asp:Parameter Name="STATUS" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_MR_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlDownload" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MR_NO, MR_REV, MR_TITLE, DISCIPLINE_CODE, STATUS, MR_ITEM_NO,
ITEM_OCCURENCE, TAG_NO, CLIENT_PART_NO, ITEM_DESCR, MR_QTY,
PREV_QTY, DELTA_QTY, DELIVERY_POINT, CONSTRUCTION_AREA 
FROM VIEW_MAT_REQUISITION"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlPOBalance" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_MR_PO_BALANCE WHERE PO_BALANCE<>0"></asp:SqlDataSource>
</asp:Content>

