<%@ Page Title="Site MIV" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SiteMIV.aspx.cs" Inherits="Erection_SiteMIV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function OnClientClicking(sender, args) {
            var callBackFunction = Function.createDelegate(sender, function (argument) {
                if (argument) {
                    this.click();
                }
            });
            var text = "Are you sure you want to continue?";
            radconfirm(text, callBackFunction, 300, 100, null, "Delete");
            args.set_cancel(true);
        }
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=itemsGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 180 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnCreateMIV" runat="server" Text="Register" Width="100px"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMaterial" runat="server" Text="Material" Width="100px" OnClick="btnMaterial_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="100px" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                        EmptyMessage="Search Here" Width="200px" AutoPostBack="True">
                    </telerik:RadTextBox></td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGridView" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"  AllowAutomaticUpdates="true" AllowAutomaticDeletes="True" AllowPaging="True" PageSize="30">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                <Selecting AllowRowSelect="True"></Selecting>
                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" DataKeyNames="ISSUE_ID"
                AllowAutomaticUpdates="true" AllowAutomaticDeletes="True"  AllowPaging="True" PageSize="30">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this Job Card?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                    </telerik:GridButtonColumn>
                    <telerik:GridTemplateColumn DataField="ISSUE_NO" FilterControlAltText="Filter ISSUE_NO column" HeaderText="ISSUE_NO" SortExpression="ISSUE_NO" UniqueName="ISSUE_NO">
                        <EditItemTemplate>
                            <asp:TextBox ID="ISSUE_NOTextBox" runat="server" Text='<%# Bind("ISSUE_NO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="ISSUE_NOLabel" runat="server" Text='<%# Eval("ISSUE_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="ISSUE_DATE" DataType="System.DateTime" FilterControlAltText="Filter ISSUE_DATE column" HeaderText="ISSUE_DATE" SortExpression="ISSUE_DATE" UniqueName="ISSUE_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="ISSUE_DATETextBox" runat="server" SelectedDate='<%# Bind("ISSUE_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="ISSUE_DATELabel" runat="server" Text='<%# Bind("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn ReadOnly="true" DataField="ISSUE_BY" FilterControlAltText="Filter ISSUE_BY column" HeaderText="ISSUE_BY" SortExpression="ISSUE_BY" UniqueName="ISSUE_BY">
                        <EditItemTemplate>
                            <asp:TextBox ID="ISSUE_BYTextBox" runat="server" Text='<%# Bind("ISSUE_BY") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="ISSUE_BYLabel" runat="server" Text='<%# Eval("ISSUE_BY") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="SITE_JC_NO" FilterControlAltText="Filter SITE_JC_NO column" HeaderText="SITE_JC_NO" SortExpression="SITE_JC_NO" UniqueName="SITE_JC_NO" ReadOnly="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_DATE" DataFormatString="{0:dd-MMM-yyyy}" ReadOnly="true" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column" HeaderText="CREATE_DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JC_SUBCON" ReadOnly="true" FilterControlAltText="Filter JC_SUBCON column" HeaderText="JC_SUBCON" SortExpression="JC_SUBCON" UniqueName="JC_SUBCON">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="STORE_NAME" ReadOnly="true" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE_NAME" SortExpression="STORE_NAME" UniqueName="STORE_NAME">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                        <EditItemTemplate>
                            <asp:TextBox ID="REMARKSTextBox" runat="server" Text='<%# Bind("REMARKS") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="REMARKSLabel" runat="server" Text='<%# Eval("REMARKS") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsErectionBTableAdapters.VIEW_SITE_MIVTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_ISSUE_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ISSUE_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_ISSUE_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

