<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TestPkg.aspx.cs" Inherits="TestPkg_TestPkg" Title="Test Package" %>



<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= tpGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; background-color: whitesmoke">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnView" runat="server" Text="View" Width="85px" OnClick="btnView_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnRegister" runat="server" Text="Register" Width="85px" OnClick="btnRegister_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnTpkIsome" runat="server" Text="Isome" Width="80px" OnClick="btnTpkIsome_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnAddItems" runat="server" Text="Spools" Width="80px" OnClick="btnAddItems_Click" Visible="False" />
                        </td>
                       
                        <td style="width: 100%" align="right">
                            <telerik:RadTextBox EmptyMessage="Search" ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" Visible="false"
                                Width="150px">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <telerik:RadGrid ID="tpGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataSourceID="tpDataSource" CellSpacing="-1" AllowFilteringByColumn="True"
                    DataKeyNames="TPK_ID" PagerStyle-AlwaysVisible="true" PageSize="50">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True"></Selecting>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" FrozenColumnsCount="3"></Scrolling>
                    </ClientSettings>

                    <MasterTableView DataKeyNames="TPK_ID" AllowPaging="true">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="TPK_NUMBER" HeaderText="Test Package No" SortExpression="TPK_NUMBER" FilterControlAltText="Filter TPK_NUMBER column" UniqueName="TPK_NUMBER" AutoPostBackOnFilter="true" AllowFiltering="true">
                                <ItemStyle Width="180px" />
                                <HeaderStyle Width="180px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SYS_NUMBER" HeaderText="System No" SortExpression="SYS_NUMBER" FilterControlAltText="Filter SYS_NUMBER column" UniqueName="SYS_NUMBER" AutoPostBackOnFilter="true" AllowFiltering="true">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TEST_PRESS" HeaderText="Test Press" SortExpression="TEST_PRESS" FilterControlAltText="Filter TEST_PRESS column" UniqueName="TEST_PRESS" AllowFiltering="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TEST_MEDIA" HeaderText="Test Med" SortExpression="TEST_MEDIA" FilterControlAltText="Filter TEST_MEDIA column" UniqueName="TEST_MEDIA" AllowFiltering="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LINE_SRV" HeaderText="Line Service" SortExpression="LINE_SRV" FilterControlAltText="Filter LINE_SRV column" UniqueName="LINE_SRV" AllowFiltering="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="READY_FOR_TEST_DATE" HeaderText="Ready for Test" SortExpression="READY_FOR_TEST_DATE" FilterControlAltText="Filter READY_FOR_TEST_DATE column" UniqueName="READY_FOR_TEST_DATE" AllowFiltering="false"
                                DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <%-- <telerik:GridBoundColumn DataField="READY_FOR_TEST_DATE" HeaderText="Ready for Test" SortExpression="READY_FOR_TEST_DATE"
                                DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />--%>
                            <telerik:GridBoundColumn DataField="PRESS_TEST_COMPLT" HeaderText="Test Complete" SortExpression="PRESS_TEST_COMPLT" FilterControlAltText="Filter PRESS_TEST_COMPLT column" UniqueName="PRESS_TEST_COMPLT" AllowFiltering="false"
                                DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" FilterControlAltText="Filter REMARKS column" UniqueName="REMARKS" AllowFiltering="false">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td style="background-color: whitesmoke;">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnPunchList" runat="server" Text="Punch List" Width="84px" OnClick="btnPunchList_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80px" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" Text="Yes" Visible="False" Width="44px" OnClick="btnYes_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                EnableViewState="False" Text="No" Visible="False" Width="44px" />
                        </td>
                         <td>
                            <telerik:RadMenu ID="RadMenu1" runat="server" EnableOverlay="false" CssClass="RadMenuStyle" OnItemClick="RadMenu1_ItemClick" Width="130px">
                                <Items>
                                    <telerik:RadMenuItem Text="Bulk Import" Value="IMPORT" ImageUrl="../Images/icons/arrow-down.png">
                                        <Items>
                                            <telerik:RadMenuItem Text="Bulk Sys Definition" Value="SYS_DEF"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Text="Bulk Test Pack Import" Value="TEST_IMP"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Text="Bulk TPK Isome Import" Value="TPK_ISOME"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Text="Bulk TPK Spool Import" Value="TPK_SPL"></telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenuItem>
                                </Items>
                            </telerik:RadMenu>
                        </td>
                        <td style="width: 100%" align="right">
                            <telerik:RadDropDownList ID="cboReports" runat="server" Width="332px"  EnableDirectionDetection="true">
                                <Items>
                                    <telerik:DropDownListItem Value="1001" Text="Test Pack  History Sheet(New)" />
                                    <telerik:DropDownListItem Value="1000" Text="Test Pack  History Sheet(Old)" />
                                    <telerik:DropDownListItem Selected="True" Value="2" Text="Spools List" />
                                    <telerik:DropDownListItem Value="3" Text="Isometric List" />
                                    <telerik:DropDownListItem Value="6" Text="Joints List" />
                                    <telerik:DropDownListItem Value="7" Text="Loose Material List" />
                                    <telerik:DropDownListItem Value="8" Text="Field Support List" />
                                    <telerik:DropDownListItem Value="4" Text="Isometric Inch-Dia Status" />
                                    <telerik:DropDownListItem Value="5" Text="Isometric Joints Status" />
                                    <telerik:DropDownListItem Value="1000" Text="Test Pack  History Sheet" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnPrw" runat="server" Text="Preview" Width="80px" OnClick="btnPrw_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="tpDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsTestPkg_ATableAdapters.VIEW_ADAPTER_TPK_MASTERTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="Original_TPK_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>



