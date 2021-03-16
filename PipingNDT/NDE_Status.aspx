<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_Status.aspx.cs" Inherits="PipingNDT_NDE_Status" Title="NDT Status" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[

            function OpenSegment() {
                try {
                    //JOINT_ID,NDE_REQ_ID
                    var joint_id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("JOINT_ID");
                    var req_id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("NDE_REQ_ID");
                    radopen("NDE_StatusSegment.aspx?JOINT_ID=" + joint_id + "&REQ_ID=" + req_id, "RadWindow2", 650, 450);
                }
                catch (err) {
                    txt = "Select any Joint!";
                    alert(txt);
                }
            }
            function OpenStatus() {
                try {
                    //JOINT_ID,NDE_REQ_ID
                    var joint_id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("JOINT_ID");
                    var req_id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("NDE_REQ_ID");
                    radopen("NDE_StatusUpdate.aspx?JOINT_ID=" + joint_id + "&NDE_REQ_ID=" + req_id, "RadWindow2", 650, 450);
                }
                catch (err) {
                    txt = "Select any Joint!";
                    alert(txt);
                }
            }

            function RefreshParent(sender, eventArgs) {
                location.href = location.href;
            }
            window.onresize = Test;
            Sys.Application.add_load(Test);
            function Test() {
                var grid = $find('<%= RadGrid1.ClientID %>')
                var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
                var width = document.getElementById("grad").clientWidth;
                grid.get_element().style.height = (height) - document.getElementById("grad").clientHeight - document.getElementById("MasterHeader").clientHeight
                    - document.getElementById("headerButtons").clientHeight
                    - document.getElementById("MasterFooter").clientHeight - 20 + "px";
                grid.get_element().style.width = width - 25 + "px";
                grid.get_element()
                grid.repaint();
            }

            function RowDblClick(sender, eventArgs) {
                editedRow = eventArgs.get_itemIndexHierarchical();
                $find("<%= RadGrid1.ClientID %>").get_masterTableView().editItem(editedRow);
            }
        </script>

    </telerik:RadCodeBlock>
    <div style="background-color: whitesmoke;" id="headerButtons">

        <table>
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <telerik:RadDropDownList ID="ddNDE_Type" runat="server" DataSourceID="ndetypeDataSource" DataTextField="NDE_TYPE" DataValueField="NDE_TYPE_ID" Width="120px"
                                AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddNDE_Type_SelectedIndexChanged">
                                <Items>
                                    <telerik:DropDownListItem Text="NDE Type" Value="-1" Selected="true" />
                                </Items>
                            </telerik:RadDropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <%-- <td>
                    <asp:ImageButton ID="ImageButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" />
                </td>--%>
                <td>
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClientClick="OpenStatus(); return false;">
                        <telerik:RadButton ID="btnStatus" runat="server" Text="Update Status" Width="150"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="OpenSegment(); return false;">
                        <telerik:RadButton ID="btnSegment" runat="server" Text="Segment"></telerik:RadButton>
                    </asp:LinkButton>

                </td>
                <td>
                    <telerik:RadButton ID="btnPenalty" runat="server" Text="Penalty" Width="80" OnClick="btnPenalty_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnBulkRep" runat="server" Text="BulkRequest\Update" OnClick="btnBulkRep_Click" Width="150"></telerik:RadButton>
                </td>

            </tr>
        </table>
    </div>
    <div>
        <%--     <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>

                <table runat="server" id="FilterTable" visible="false" style="width: 100%">
                    <tr>
                        <td style="background-color: Gainsboro; width: 150px">NDT Type
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddNDE_Type" runat="server" DataSourceID="ndetypeDataSource" DataTextField="NDE_TYPE" DataValueField="NDE_TYPE_ID" Width="120px"
                                AppendDataBoundItems="True" OnDataBinding="ddNDE_Type_DataBinding">
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: Gainsboro; width: 150px">NDT Request No</td>
                        <td>
                            <telerik:RadTextBox ID="txtRequestNo" runat="server" Width="200px" EmptyMessage="All Requests"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: Gainsboro; width: 150px">NDT Report No</td>
                        <td>
                            <telerik:RadTextBox ID="txtReportNo" runat="server" Width="150px" EmptyMessage="All Reports"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: Gainsboro; width: 150px">Isometric No</td>
                        <td>
                            <telerik:RadSearchBox ID="IsomeRadSearchBox" runat="server" Width="250px" EmptyMessage="All Isometric" DropDownSettings-Height="400" ShowSearchButton="False"
                                DataSourceID="IsomeSqlDataSource" DataTextField="ISO_TITLE1" DataValueField="ISO_TITLE1" MinFilterLength="2">
                            </telerik:RadSearchBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: Gainsboro; width: 150px">Joint No</td>
                        <td>
                            <telerik:RadTextBox ID="txtJointNo" runat="server" Width="80px" EmptyMessage="All Joints"></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>--%>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="NdeReqDataSource"
                DataKeyNames="JOINT_ID,NDE_REQ_ID" AllowFilteringByColumn="True" AllowAutomaticUpdates="True" OnItemDataBound="RadGrid1_ItemDataBound"
                PagerStyle-AlwaysVisible="true" PageSize="50" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" OnUpdateCommand="RadGrid1_UpdateCommand"
                OnDeleteCommand="RadGrid1_DeleteCommand">

                <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                    <Selecting AllowRowSelect="True"></Selecting>
                    <Scrolling AllowScroll="True" UseStaticHeaders="True" FrozenColumnsCount="3"></Scrolling>
                    <Virtualization EnableVirtualization="true" InitiallyCachedItemsCount="100" ItemsPerView="100" />
                </ClientSettings>
                <ClientSettings AllowKeyboardNavigation="true">
                    <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                        AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                </ClientSettings>
                <ClientSettings>
                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                </ClientSettings>
                <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataSourceID="NdeReqDataSource" HierarchyLoadMode="Client" PageSize="15"
                    EditMode="InPlace" EditFormSettings-PopUpSettings-Modal="true" DataKeyNames="JOINT_ID,NDE_REQ_ID" ClientDataKeyNames="JOINT_ID,NDE_REQ_ID" CommandItemDisplay="Top">
                    <CommandItemSettings ShowAddNewRecordButton="false" />
                    <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="50px" UniqueName="EditCommandColumn">
                            <ItemStyle Width="50px" />
                            <HeaderStyle Width="50px" />
                        </telerik:GridEditCommandColumn>
                         <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" >
                            <ItemStyle Width="50px" />
                            <HeaderStyle Width="50px" />
                        </telerik:GridButtonColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="PDF">
                            <ItemTemplate>
                                <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="40px" />
                            <HeaderStyle Width="40px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="Isometric No" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1" AllowFiltering="true" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                            <ItemStyle Width="140px" />
                            <HeaderStyle Width="140px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JOINT_NO" FilterControlAltText="Filter JOINT_NO column" HeaderText="Joint No" SortExpression="JOINT_NO" UniqueName="JOINT_NO" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                            <ItemStyle Width="100px" />
                            <HeaderStyle Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="REV_CODE" FilterControlAltText="Filter REV_CODE column" HeaderText="Rev Code" SortExpression="REV_CODE" UniqueName="REV_CODE" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                            <ItemStyle Width="100px" />
                            <HeaderStyle Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="REPAIR_CODE" FilterControlAltText="Filter REPAIR_CODE column" HeaderText="Repair Code" SortExpression="REPAIR_CODE" UniqueName="REPAIR_CODE" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                            <ItemStyle Width="100px" />
                            <HeaderStyle Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NDE_REQ_NO" FilterControlAltText="Filter NDE_REQ_NO column" HeaderText="Request No" SortExpression="NDE_REQ_NO" UniqueName="NDE_REQ_NO" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                            <ItemStyle Width="140px" />
                            <HeaderStyle Width="140px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NDE_TYPE" FilterControlAltText="Filter NDE_TYPE column" HeaderText="NDT Type" SortExpression="NDE_TYPE" UniqueName="NDE_TYPE" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                            <ItemStyle Width="100px" />
                            <HeaderStyle Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NDE_REP_NO" FilterControlAltText="Filter NDE_REP_NO column" HeaderText="Report No" SortExpression="NDE_REP_NO" UniqueName="NDE_REP_NO" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                            <ItemStyle Width="120px" />
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn DataField="NDE_DATE" DataType="System.DateTime" FilterControlAltText="Filter NDE_DATE column" HeaderText="NDT Date"
                            SortExpression="NDE_DATE" UniqueName="NDE_DATE" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="RadDatePicker1" runat="server" SelectedDate='<%# Bind("NDE_DATE") %>' DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="NDE_DATELabel" runat="server" Text='<%# Eval("NDE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" />
                            <HeaderStyle Width="200px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="TOTAL_FILM1" DataType="System.Decimal" FilterControlAltText="Filter TOTAL_FILM1 column" HeaderText="Total Films" SortExpression="TOTAL_FILM1" UniqueName="TOTAL_FILM1" AllowFiltering="false">
                            <ItemStyle Width="80px" />
                            <HeaderStyle Width="80px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TOTAL_FILM2" DataType="System.Decimal" FilterControlAltText="Filter TOTAL_FILM2 column" HeaderText="Accepted Films" SortExpression="TOTAL_FILM2" UniqueName="TOTAL_FILM2" AllowFiltering="false">
                            <ItemStyle Width="80px" />
                            <HeaderStyle Width="80px" />
                        </telerik:GridBoundColumn>

                        <%-- <telerik:GridBoundColumn DataField="PASS_FLG" FilterControlAltText="Filter PASS_FLG column" HeaderText="Pass Flag" SortExpression="PASS_FLG" UniqueName="PASS_FLG" ReadOnly="true">
                        </telerik:GridBoundColumn>--%>

                        <telerik:GridTemplateColumn DataField="PASS_FLG" FilterControlAltText="Filter PASS_FLG column" HeaderText="Pass Flag" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                            <ItemTemplate>
                                <asp:Label ID="LabelSubconEdit" runat="server" Text='<%# Bind("PASS_FLG") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownListSubconEdit" runat="server" AppendDataBoundItems="True" DataSourceID="NDEPassFlgDataSource"
                                    DataTextField="PASS_FLG" DataValueField="PASS_FLG_ID" SelectedValue='<%# Bind("PASS_FLG_ID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemStyle Width="150px" />
                            <HeaderStyle Width="150px" />
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

    <asp:ObjectDataSource ID="NdeReqDataSource" runat="server" SelectMethod="GetData" UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery"
        TypeName="dsNDETableAdapters.VIEW_ADAPTER_NDE_STATUSTableAdapter" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="ddNDE_Type" DefaultValue="-1" Name="NDE_TYPE_ID" PropertyName="SelectedValue" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="NDE_REP_NO" Type="String" />
            <asp:Parameter Name="TOTAL_FILM1" Type="Decimal" />
            <asp:Parameter Name="TOTAL_FILM2" Type="Decimal" />
            <asp:Parameter Name="PASS_FLG_ID" Type="Decimal" />
            <asp:Parameter Name="NDE_DATE" Type="DateTime" />
            <asp:Parameter Name="REPAIR_CODE" Type="String" />
            <asp:Parameter Name="Original_JOINT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_NDE_REQ_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
             <asp:Parameter Name="Original_JOINT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_NDE_REQ_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <asp:SqlDataSource ID="ndetypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT NDE_TYPE_ID, NDE_TYPE FROM PIP_NDE_TYPE ORDER BY NDE_TYPE'></asp:SqlDataSource>

    <asp:SqlDataSource ID="NDEPassFlgDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand='SELECT PASS_FLG_ID, PASS_FLG FROM PIP_NDE_PASS_FLG UNION SELECT null,null FROM DUAL'></asp:SqlDataSource>

</asp:Content>
