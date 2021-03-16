<%@ Page Title="Coating Spools" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SpoolCoatingJCDetail.aspx.cs" Inherits="SpoolMove_SpoolCoatingJCDetail" %>

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
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnAddSpool" runat="server" Text="Add Spool" Width="150px"></telerik:RadButton>
                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="200px" EmptyMessage="Search..." AutoPostBack="true">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"
            AllowPaging="True" PageSize="20" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                <Selecting AllowRowSelect="True"></Selecting>
                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace"
                PageSize="20" AllowPaging="true" DataKeyNames="SPL_ID,JC_ID">
                <Columns>
                    <telerik:GridButtonColumn ConfirmText="Delete this item?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISO_TITLE1" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="SPOOL" SortExpression="SPOOL" UniqueName="SPOOL">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_SIZE" FilterControlAltText="Filter SPL_SIZE column" HeaderText="SPL_SIZE" SortExpression="SPL_SIZE" UniqueName="SPL_SIZE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PS" FilterControlAltText="Filter PS column" HeaderText="PS" SortExpression="PS" UniqueName="PS">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_SURFACE" FilterControlAltText="Filter SPL_SURFACE column" HeaderText="SPL_SURFACE" SortExpression="SPL_SURFACE" UniqueName="SPL_SURFACE" DataType="System.Decimal">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_INNER_SURF" DataType="System.Decimal" FilterControlAltText="Filter SPL_INNER_SURF column" HeaderText="SPL_INNER_SURF" SortExpression="SPL_INNER_SURF" UniqueName="SPL_INNER_SURF">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="COAT_REP_NO" FilterControlAltText="Filter COAT_REP_NO column" HeaderText="COAT_REP_NO" SortExpression="COAT_REP_NO" UniqueName="COAT_REP_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="COAT_REP_DT" FilterControlAltText="Filter COAT_REP_DT column" HeaderText="COAT_REP_DT" SortExpression="COAT_REP_DT" UniqueName="COAT_REP_DT" EditFormHeaderTextFormat="dd-MMM-yyyy">
                        <EditItemTemplate>
                            <asp:TextBox ID="COAT_REP_DTTextBox" runat="server" Text='<%# Bind("COAT_REP_DT", "{0:dd-MMM-yyyy}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="COAT_REP_DTLabel" runat="server" Text='<%# Eval("COAT_REP_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="BLAST_REP_NO" FilterControlAltText="Filter BLAST_REP_NO column" HeaderText="BLAST_REP_NO" SortExpression="BLAST_REP_NO" UniqueName="BLAST_REP_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="BLAST_REP_DT" DataType="System.DateTime" EditFormHeaderTextFormat="{0:dd-MMM-yyyy}" FilterControlAltText="Filter BLAST_REP_DT column" HeaderText="BLAST_REP_DT" SortExpression="BLAST_REP_DT" UniqueName="BLAST_REP_DT">
                        <EditItemTemplate>
                            <asp:TextBox ID="BLAST_REP_DTTextBox" runat="server" Text='<%# Bind("BLAST_REP_DT") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="BLAST_REP_DTLabel" runat="server" Text='<%# Eval("BLAST_REP_DT") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGalvJobcardTableAdapters.VIEW_COATING_JC_SPLTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JC_ID" QueryStringField="JC_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

