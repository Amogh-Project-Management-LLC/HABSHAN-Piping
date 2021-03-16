<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SystemDef.aspx.cs" Inherits="TestPkg_Systems" Title="System Definition" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= sysGridView.ClientID %>')
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
                <telerik:RadButton ID="btnRegister" runat="server" OnClick="btnRegister_Click" Text="Register" Width="85px" />
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <telerik:RadGrid ID="sysGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="True" PagerStyle-AlwaysVisible="true"
                    CssClass="DataWebControlStyle" DataKeyNames="SYS_ID" DataSourceID="sysDataSource"
                    PageSize="50" Width="100%">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True"></Selecting>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" FrozenColumnsCount="3"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="SYS_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="50px" />
                                <HeaderStyle Width="50px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="SYS_NUMBER" HeaderText="SYS NUMBER" SortExpression="SYS_NUMBER" AutoPostBackOnFilter="true" AllowFiltering="true">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SUB_SYS_NO" HeaderText="SUB SYSTEM" SortExpression="SUB_SYS_NO" AutoPostBackOnFilter="true" AllowFiltering="true">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn HeaderText="MECH TRGT" SortExpression="MECH_TARGET" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MECH_TARGET", "{0:dd-MMM-yyyy}") %>'
                                        Width="80px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle Width="100px" />
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("MECH_TARGET", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="SYS TRGT" SortExpression="SYS_TARGET" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("SYS_TARGET", "{0:dd-MMM-yyyy}") %>'
                                        Width="80px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle Width="100px" />
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("SYS_TARGET", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="PRIORITY" SortExpression="PRIORITY" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PRIORITY") %>' Width="63px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("PRIORITY") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="SYS DESCRIPTION" SortExpression="SYS_DESCR" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("SYS_DESCR") %>' Width="90%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("SYS_DESCR") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="SUB SYS DESCRIPTION" SortExpression="SUB_SYS_DESCR" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSubSys" runat="server" Text='<%# Bind("SUB_SYS_DESCR") %>' Width="90%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("SUB_SYS_DESCR") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="REMARKS" SortExpression="REMARKS" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox5" runat="server" Height="90%" Text='<%# Bind("REMARKS") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td style="width: 100%; height: 20px; background-color: whitesmoke;">
                <telerik:RadButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" Width="80px" />
                <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="44px" />
                <telerik:RadButton ID="btnNo" runat="server" BorderColor="SteelBlue" EnableViewState="False" Text="No" Visible="False" Width="44px" />
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="sysDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsTestPkg_ATableAdapters.TPK_SYSTEM_DEFINITIONTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_SYS_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SYS_NUMBER" Type="String" />
            <asp:Parameter Name="SUB_SYS_NO" Type="String" />
            <asp:Parameter Name="MECH_TARGET" Type="DateTime" />
            <asp:Parameter Name="SYS_TARGET" Type="DateTime" />
            <asp:Parameter Name="PRIORITY" Type="Decimal" />
            <asp:Parameter Name="SYS_DESCR" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SUB_SYS_DESCR" Type="String" />
            <asp:Parameter Name="Original_SYS_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
