<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TestPkg_Isome.aspx.cs" Inherits="TestPkg_Isome" Title="Test Package/ Isometrics" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= isomeGridView.ClientID %>')
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
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" Width="84px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnEntryMode" runat="server" OnClick="btnEntryMode_Click" Text="Entry" Width="84px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSpools" runat="server" Text="Spools" Width="84px" OnClick="btnSpools_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <telerik:RadGrid ID="isomeGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="True" PagerStyle-AlwaysVisible="true"
                    CssClass="DataWebControlStyle" DataSourceID="itemsDataSource" Width="100%" PageSize="50"
                    DataKeyNames="TPK_ID,ISO_ID">
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True"></Selecting>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" FrozenColumnsCount="3"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="TPK_ID,ISO_ID" AllowAutomaticUpdates="true">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="30px" />
                                <HeaderStyle Width="30px" />
                            </telerik:GridEditCommandColumn>
                             
                            <telerik:GridBoundColumn DataField="LINE_NO" HeaderText="Line No" ReadOnly="True" SortExpression="LINE_NO" AutoPostBackOnFilter="true" AllowFiltering="true">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isome Dwg No" ReadOnly="True"
                                SortExpression="ISO_TITLE1" AutoPostBackOnFilter="true" AllowFiltering="true">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AREA_L1" HeaderText="Area" ReadOnly="True" SortExpression="AREA_L1" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LINE_SIZE" HeaderText="Line Size" ReadOnly="True" SortExpression="LINE_SIZE" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn HeaderText="Remarks" SortExpression="REMARKS" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("REMARKS") %>' Width="95%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
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
            <td style="width: 100%">
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnRefresh" runat="server"
                                OnClick="btnRefresh_Click" Text="Refresh" Width="84px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server"
                                OnClick="btnDelete_Click" Text="Delete" Width="84px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" BackColor="LightBlue" BorderColor="SteelBlue"
                                EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="41px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" BackColor="LightBlue" BorderColor="SteelBlue"
                                EnableViewState="False" Text="No" Visible="False" Width="41px" />
                        </td>
                        <td align="right" style="width: 100%">
                            <telerik:RadTextBox EmptyMessage="Isometric No" ID="txtLineNo" runat="server" AutoPostBack="True"
                                Visible="False" Width="249px">
                            </telerik:RadTextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="cboNewIsome" runat="server" DataSourceID="isomeDataSource"
                                DataTextField="ISO_TITLE1" DataValueField="ISO_ID" Visible="False" Width="200px">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnAddIsome" runat="server" OnClick="btnAddSpool_Click" Text="Add Isome" Width="90px" Visible="False" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsTestPkg_BTableAdapters.VIEW_ADAPTER_TPK_ISOMETableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TPK_ID" Type="Decimal" />
            <asp:Parameter Name="Original_ISO_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_TPK_ID" Type="Decimal" />
            <asp:Parameter Name="Original_ISO_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TPK_ID" QueryStringField="TPK_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="isomeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_ID, ISO_TITLE1 FROM PIP_ISOMETRIC &#13;&#10;WHERE (PROJ_ID = :PROJECT_ID) AND &#13;&#10;((LINE_NO = :LINE_NO) OR (ISO_TITLE1 = :LINE_NO))&#13;&#10;ORDER BY ISO_TITLE1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtLineNo" DefaultValue="~" Name="LINE_NO" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
