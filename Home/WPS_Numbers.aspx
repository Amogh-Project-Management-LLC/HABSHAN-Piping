<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="WPS_Numbers.aspx.cs" Inherits="WeldingInspec_WPS_Numbers" Title="WPS" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[
            function RowDblClick(sender, eventArgs) {
                editedRow = eventArgs.get_itemIndexHierarchical();
                $find("<%= wpsGridView.ClientID %>").get_masterTableView().editItem(editedRow);
            }
            function RowDblClickCancel(sender, eventArgs) {
                return false;
            }


            function ShowClass() {
                try {
                    var id = $find("<%=wpsGridView.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("WPS_ID");
                    radopen("WPS_Class.aspx?WPS_ID=" + id, "RadWindow2", 450, 450);
                }
                catch (err) {
                    txt = "Select any WPS_Number!";
                    alert(txt);
                }
            }

            window.onresize = Test;
            Sys.Application.add_load(Test);
            function Test() {
                var grid = $find('<%= wpsGridView.ClientID %>')
                var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
                var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;


                grid.get_element().style.height = (height) - 200 + "px";
                grid.get_element().style.width = width - 25 + "px";
                grid.get_element()
                grid.repaint();
            }


        </script>
    </telerik:RadCodeBlock>

    <div style="background-color: whitesmoke">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnRegister" runat="server" OnClick="btnRegister_Click" Text="Register"
                        Width="80px" />
                </td>
                <td>
                    <telerik:RadButton ID="btnWPS_Details" runat="server" OnClick="btnWPS_Details_Click" Text="Details"
                        Width="80px" />
                </td>
                <td>
                    <asp:LinkButton ID="linkShowClass" runat="server" OnClientClick="ShowClass(); return false;" Font-Underline="false"
                        ForeColor="#003366">
                        <telerik:RadButton ID="btnWPSClass" runat="server" OnClick="btnWPSClass_Click" Text="Class"
                            Width="80px" />
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnImport" runat="server" OnClick="btnImport_Click" Text="Import.." Width="100px">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>
                </td>
                <td align="right" style="width: 100%">
                    <telerik:RadTextBox EmptyMessage="Search.." ID="txtSearch" runat="server" Width="200px" ClientEvents-OnKeyPress="handleSpace(event)"
                        OnTextChanged="txtSearch_TextChanged" Visible="false">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="140px" Visible="false">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <telerik:RadGrid ID="wpsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowAutomaticDeletes="true"
                    CssClass="DataWebControlStyle" DataKeyNames="WPS_ID" DataSourceID="wpsDataSource" AllowFilteringByColumn="true"
                    PageSize="50" OnDataBound="wpsGridView_DataBound">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <ClientSettings AllowKeyboardNavigation="true">
                        <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                            AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>

                    </ClientSettings>
                    <MasterTableView DataKeyNames="WPS_ID" ClientDataKeyNames="WPS_ID" AllowPaging="true" PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridButtonColumn ConfirmText="Delete this Spool?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                                <ItemStyle Width="50px" />
                                <HeaderStyle Width="50px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="WPS_NO1" HeaderText="WPS Number" ReadOnly="True" SortExpression="WPS_NO1"
                                FilterControlWidth="70px" AutoPostBackOnFilter="true">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REV" HeaderText="Rev" SortExpression="REV" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME" FilterControlWidth="70px"
                                AutoPostBackOnFilter="true">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PROCESS" HeaderText="Process" SortExpression="PROCESS" FilterControlWidth="60px" AutoPostBackOnFilter="true">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PWHT" HeaderText="PWHT" SortExpression="PWHT" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SIZE_FROM" HeaderText="Size From" SortExpression="SIZE_FROM" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SIZE_TO" HeaderText="Size To" SortExpression="SIZE_TO" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="THK_FROM" HeaderText="Thick From" SortExpression="THK_FROM" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="THK_TO" HeaderText="Thick To" SortExpression="THK_TO" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ALL_SUBCON" HeaderText="Common WPS" SortExpression="ALL_SUBCON" AllowFiltering="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PIPE_CLASS" HeaderText="PIPE Class" SortExpression="PIPE_CLASS" FilterControlWidth="60px" AutoPostBackOnFilter="true">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>

                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />


                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="wpsDataSource" runat="server" SelectMethod="GetData" TypeName="dsWeldingBTableAdapters.PIP_WPS_NOTableAdapter"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:SessionParameter DefaultValue="-1" Name="SC_ID" SessionField="CONNECT_AS" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text"
                Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_WPS_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>
