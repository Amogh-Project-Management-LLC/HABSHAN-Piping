<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_RequestJoints.aspx.cs" Inherits="WeldingInspec_NDE_RequestJoints"
    Title="NDE Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth;
            grid.get_element().style.height = (height) - document.getElementById("grad").clientHeight - document.getElementById("MasterHeader").clientHeight
                - document.getElementById("headerButtons").clientHeight - document.getElementById("MasterFooter").clientHeight - 20 + "px";
            grid.get_element().style.width = width - 25 + "px";
            grid.get_element()
            grid.repaint();
        }
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= RadGrid1.ClientID %>").get_masterTableView().editItem(editedRow);
        }
    </script>
    <div id="headerButtons">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Add Joint" Width="80px"></telerik:RadButton>
                </td>

                <td>
                    <telerik:RadButton ID="btnAutoRequest" runat="server" Text="Auto Request 100%" Width="140px" OnClick="btnAutoRequest_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnManualRequest" runat="server" Text="Manual Selection" Width="140px" OnClick="btnManualRequest_Click"></telerik:RadButton>
                </td>

                <td>
                    <asp:DropDownList ID="cboNewJoint" runat="server" Width="350px" DataSourceID="newjointDataSource"
                        DataTextField="JOINT_TITLE" DataValueField="JOINT_ID" Visible="False" OnDataBinding="cboNewJoint_DataBinding">
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddJoint" runat="server" Text="Save" Width="80px" OnClick="btnAddJoint_Click" Visible="false"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="true"
                    DataSourceID="NdeReqJntDataSource" OnUpdateCommand="RadGrid1_UpdateCommand" OnItemCommand="RadGrid1_ItemCommand"
                    EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowSorting="true"  CellSpacing="-1">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <ClientSettings AllowKeyboardNavigation="true">
                        <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                            AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                    </ClientSettings>
                    <ClientSettings>
                        <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    </ClientSettings>
                    <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataKeyNames="NDE_ITEM_ID" DataSourceID="NdeReqJntDataSource"
                        EditFormSettings-PopUpSettings-Modal="true" EditMode="PopUp" HierarchyLoadMode="Client" PageSize="50" PagerStyle-AlwaysVisible="true">
                        <Columns>
                               <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="45px" UniqueName="EditCommandColumn">
                                <ItemStyle Width="45px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn" ItemStyle-Width="20px">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="Isometric No" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1" ReadOnly="true" AllowFiltering="true" AutoPostBackOnFilter="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="JOINT_TYPE" FilterControlAltText="Filter JOINT_TYPE column" HeaderText="Joint Type" SortExpression="JOINT_TYPE" UniqueName="JOINT_TYPE" ReadOnly="true" AllowFiltering="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="JOINT_NO" FilterControlAltText="Filter JOINT_NO column" HeaderText="Joint No" SortExpression="JOINT_NO" UniqueName="JOINT_NO" ReadOnly="true" AllowFiltering="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="JNT_REV_CODE" FilterControlAltText="Filter JNT_REV_CODE column" HeaderText="Joint Rev" SortExpression="JNT_REV_CODE" UniqueName="JNT_REV_CODE" ReadOnly="true" AllowFiltering="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CRW_CODE" FilterControlAltText="Filter CRW_CODE column" HeaderText="Joint CRW" SortExpression="CRW_CODE" UniqueName="CRW_CODE" ReadOnly="true" AllowFiltering="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REPAIR_CODE" FilterControlAltText="Filter REPAIR_CODE column" HeaderText="Repair Code" SortExpression="REPAIR_CODE" UniqueName="REPAIR_CODE" AllowFiltering="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REP_CON_NO" DataType="System.Decimal" FilterControlAltText="Filter REP_CON_NO column" HeaderText="Rep Con No" SortExpression="REP_CON_NO" UniqueName="REP_CON_NO" AllowFiltering="false" ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NDE_REP_NO" FilterControlAltText="Filter NDE_REP_NO column" HeaderText="Report No" SortExpression="NDE_REP_NO" UniqueName="NDE_REP_NO" AllowFiltering="true" AutoPostBackOnFilter="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn DataField="NDE_DATE" DataType="System.DateTime" FilterControlAltText="Filter NDE_DATE column" HeaderText="NDE Date" SortExpression="NDE_DATE" UniqueName="NDE_DATE" AllowFiltering="true" AutoPostBackOnFilter="true"
                                DataFormatString="{0:dd-MMM-yyyy}" EditDataFormatString="dd-MMM-yyyy">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn DataField="TOTAL_FILM1" DataType="System.Decimal" FilterControlAltText="Filter TOTAL_FILM1 column" HeaderText="Total Films" SortExpression="TOTAL_FILM1" UniqueName="TOTAL_FILM1" AllowFiltering="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TOTAL_FILM2" DataType="System.Decimal" FilterControlAltText="Filter TOTAL_FILM2 column" HeaderText="Accpeted Films" SortExpression="TOTAL_FILM2" UniqueName="TOTAL_FILM2" AllowFiltering="false">
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn DataField="PASS_FLG" FilterControlAltText="Filter PASS_FLG column" HeaderText="Pass Flag" SortExpression="PASS_FLG" UniqueName="PASS_FLG" AllowFiltering="true" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <asp:Label ID="LabelPassFlg" runat="server" Text='<%# Bind("PASS_FLG") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownListFlagEdit" runat="server" AppendDataBoundItems="True" DataSourceID="PassFlgDataSource"
                                        DataTextField="PASS_FLG" DataValueField="PASS_FLG_ID" SelectedValue='<%# Bind("PASS_FLG_ID") %>'
                                        Width="150px">
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                            <PopUpSettings Modal="True" />
                        </EditFormSettings>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:ObjectDataSource ID="NdeReqJntDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsNDETableAdapters.VIEW_ADAPTER_NDE_JOINTSTableAdapter"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="NDE_REQ_ID" QueryStringField="NDE_REQ_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_NDE_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="REPAIR_CODE" Type="String" />
            <asp:Parameter Name="PASS_FLG_ID" Type="Decimal" />
            <asp:Parameter Name="NDE_REP_NO" Type="String" />
            <asp:Parameter Name="NDE_DATE" Type="DateTime" />
            <asp:Parameter Name="TOTAL_FILM1" Type="Decimal" />
            <asp:Parameter Name="TOTAL_FILM2" Type="Decimal" />
            <asp:Parameter Name="Original_NDE_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="newjointDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="PassFlgDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PASS_FLG_ID, PASS_FLG FROM PIP_NDE_PASS_FLG"></asp:SqlDataSource>
    <asp:SqlDataSource ID="ReworkCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PROJECT_ID, REWORK_CODE FROM PIP_NDE_REWORK_CODE ORDER BY REWORK_CODE"></asp:SqlDataSource>
</asp:Content>
