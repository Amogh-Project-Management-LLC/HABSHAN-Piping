<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="WelderRegistration.aspx.cs" Inherits="WeldingInspec_WelderRegistration"
    Title="Welders" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= welderGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewWelder" runat="server" Text="New" Width="100"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnWelderQualify" runat="server" Text="Qualification" Width="100" OnClick="btnWelderQualify_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnProducJoints" runat="server" Text="Production Joints" Width="150" OnClick="btnProducJoints_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnJoints" runat="server" Text="Joints Welded by this Welder" Width="220px" OnClick="btnJoints_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" EmptyMessage="Search Welder" Width="220px" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadGrid ID="welderGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" PagerStyle-AlwaysVisible="true" 
        DataKeyNames="WELDER_ID" DataSourceID="WelderDataSource" PageSize="15" OnRowUpdating="welderGridView_RowUpdating" Width="100%"
        AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
        <GroupingSettings CollapseAllTooltip="Collapse all groups" />
        <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
            <Selecting AllowRowSelect="True"></Selecting>
            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            <Virtualization EnableVirtualization="true" InitiallyCachedItemsCount="100" ItemsPerView="100" />
        </ClientSettings>
        <ClientSettings AllowKeyboardNavigation="true">
            <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
        </ClientSettings>
        <MasterTableView EditMode="InPlace" DataSourceID="WelderDataSource" DataKeyNames="WELDER_ID">
            <PagerStyle Mode="NextPrevNumericAndAdvanced" />
            <Columns>
                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                    <ItemStyle CssClass="MyImageButton" Width="10px" />
                </telerik:GridEditCommandColumn>

                <telerik:GridButtonColumn ConfirmText="Delete this Job Card?" ConfirmDialogType="RadWindow"
                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                    UniqueName="DeleteColumn">
                    <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                </telerik:GridButtonColumn>
                <telerik:GridTemplateColumn HeaderText="Welder No" SortExpression="WELDER_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("WELDER_NO") %>' Width="74px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("WELDER_NO") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Welder Name" SortExpression="W_NAME">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("W_NAME") %>' Width="105px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("W_NAME") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Status" SortExpression="STATUS">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("STATUS") %>' Width="99px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("STATUS") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Company" SortExpression="COMPANY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("COMPANY") %>' Width="91px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("COMPANY") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Nation" SortExpression="NATION">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("NATION") %>' Width="96px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("NATION") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Rel Date" SortExpression="REL_DATE">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("REL_DATE", "{0:dd-MMM-yyyy}") %>'
                            Width="75px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("REL_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="F1 Report" SortExpression="F1_REP">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("F1_REP") %>' Width="84px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("F1_REP") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="F2 Report" SortExpression="F2_REP">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("F2_REP") %>' Width="89px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("F2_REP") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="F3 Report" SortExpression="F3_REP">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("F3_REP") %>' Width="87px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("F3_REP") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Subcon" SortExpression="SC_ID">
                    <EditItemTemplate>
                        <telerik:RadDropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                            DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                            Width="116px">
                            <Items>
                                <telerik:DropDownListItem Selected="true" />
                            </Items>
                        </telerik:RadDropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label10" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Remarks" SortExpression="REMARKS">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("REMARKS") %>' Width="125px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
        <GroupingSettings CaseSensitive="false" />
    </telerik:RadGrid>

    <asp:ObjectDataSource ID="WelderDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsWeldersTableAdapters.PIP_WELDERSTableAdapter" UpdateMethod="UpdateWelder"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="WELDER_NO" Type="String" />
            <asp:Parameter Name="STATUS" Type="String" />
            <asp:Parameter Name="W_NAME" Type="String" />
            <asp:Parameter Name="COMPANY" Type="String" />
            <asp:Parameter Name="NATION" Type="String" />
            <asp:Parameter Name="REL_DATE" Type="DateTime" />
            <asp:Parameter Name="F1_REP" Type="String" />
            <asp:Parameter Name="F2_REP" Type="String" />
            <asp:Parameter Name="F3_REP" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_WELDER_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_WELDER_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
