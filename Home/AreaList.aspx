<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AreaList.aspx.cs" Inherits="Home_AreaList" Title="Areas/PCWBS" %>

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
    <table style="width: 100%;font-family:Calibri;">
        <tr>
            <td>
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnHome" runat="server" OnClick="btnHome_Click" Text="Back" Width="80" />
                            <telerik:RadButton ID="btnNew" runat="server" OnClick="btnNew_Click" Text="New" Width="80" />
                        </td>
                        <td align="right">
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="120px" Visible="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="areaDataSource" AllowPaging="True" PageSize="30"
                    AllowAutomaticUpdates="True" OnEditCommand="RadGrid1_EditCommand" MasterTableView-EditMode="InPlace" CellSpacing="-1"
                    MasterTableView-DataKeyNames="PROJECT_ID,AREA_L1" AllowFilteringByColumn="True">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true" EnablePostBackOnRowClick="false" Scrolling-EnableColumnClientFreeze="true">
                        <Selecting AllowRowSelect="True"></Selecting>

                        <Scrolling AllowScroll="True" UseStaticHeaders="True" EnableColumnClientFreeze="True"></Scrolling>
                    </ClientSettings>
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="areaDataSource">
                        <Columns>
                            <telerik:GridBoundColumn DataField="AREA_L1" AllowFiltering="true" FilterControlAltText="Filter AREA_L1 column" HeaderText="AREA_L1" SortExpression="AREA_L1" UniqueName="AREA_L1">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AREA_L2" FilterControlAltText="Filter AREA_L2 column" HeaderText="AREA_L2" SortExpression="AREA_L2" UniqueName="AREA_L2">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AREA_L3" FilterControlAltText="Filter AREA_L3 column" HeaderText="AREA_L3" SortExpression="AREA_L3" UniqueName="AREA_L3">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AGUG" FilterControlAltText="Filter AGUG column" HeaderText="AGUG" SortExpression="AGUG" UniqueName="AGUG">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AREA_GROUP" FilterControlAltText="Filter AREA_GROUP column" HeaderText="AREA_GROUP" SortExpression="AREA_GROUP" UniqueName="AREA_GROUP">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AREA_DESCR" FilterControlAltText="Filter AREA_DESCR column" HeaderText="AREA_DESCR" SortExpression="AREA_DESCR" UniqueName="AREA_DESCR">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PRIORITY" DataType="System.Decimal" FilterControlAltText="Filter PRIORITY column" HeaderText="PRIORITY" SortExpression="PRIORITY" UniqueName="PRIORITY">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FAB_SC" FilterControlAltText="Filter FAB_SC column" HeaderText="FAB_SC" SortExpression="FAB_SC" UniqueName="FAB_SC">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FIELD_SC" FilterControlAltText="Filter FIELD_SC column" HeaderText="FIELD_SC" SortExpression="FIELD_SC" UniqueName="FIELD_SC">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SCOPE_SHEET" DataType="System.Decimal" FilterControlAltText="Filter SCOPE_SHEET column" HeaderText="SCOPE_SHEET" SortExpression="SCOPE_SHEET" UniqueName="SCOPE_SHEET">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SCOPE_ISO" DataType="System.Decimal" FilterControlAltText="Filter SCOPE_ISO column" HeaderText="SCOPE_ISO" SortExpression="SCOPE_ISO" UniqueName="SCOPE_ISO">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TOTAL_SCOPE_ID" DataType="System.Decimal" FilterControlAltText="Filter TOTAL_SCOPE_ID column" HeaderText="TOTAL_SCOPE_ID" SortExpression="TOTAL_SCOPE_ID" UniqueName="TOTAL_SCOPE_ID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SCOPE_ID" DataType="System.Decimal" FilterControlAltText="Filter SCOPE_ID column" HeaderText="SCOPE_ID" SortExpression="SCOPE_ID" UniqueName="SCOPE_ID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MILESTONE" FilterControlAltText="Filter MILESTONE column" HeaderText="MILESTONE" SortExpression="MILESTONE" UniqueName="MILESTONE">
                            </telerik:GridBoundColumn>
                        </Columns>

                        <EditFormSettings>
                            <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>

        <tr>
            <td style="background-color: whitesmoke">
                <table>
                    <tr>
                        <td></td>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" Width="77px" Visible="false" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="39px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" EnableViewState="False" Text="No" Visible="False" Width="39px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="areaDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsErectionATableAdapters.VIEW_IPMS_AREATableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_AREA_L1" Type="String" />
            <asp:Parameter Name="Original_PROJECT_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="AREA_L1" Type="String" />
            <asp:Parameter Name="AREA_L2" Type="String" />
            <asp:Parameter Name="AREA_L3" Type="String" />
            <asp:Parameter Name="AREA_DESCR" Type="String" />
            <asp:Parameter Name="PRIORITY" Type="Decimal" />
            <asp:Parameter Name="SITE_CRD_DATE" Type="DateTime" />
            <asp:Parameter Name="AGUG" Type="String" />
            <asp:Parameter Name="AREA_GROUP" Type="String" />
            <asp:Parameter Name="Original_AREA_L1" Type="String" />
            <asp:Parameter Name="Original_PROJECT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>
