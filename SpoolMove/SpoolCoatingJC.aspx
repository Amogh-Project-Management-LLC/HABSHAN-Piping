<%@ Page Title="Coating JobCard" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SpoolCoatingJC.aspx.cs" Inherits="SpoolMove_SpoolCoatingJC" %>

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
            grid.get_element().style.height = (height) - 220 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNew" Text="Register" Width="80px" runat="server"></telerik:RadButton>
                    <telerik:RadButton ID="btnSpools" Text="Spools" Width="80px" runat="server" OnClick="btnSpools_Click"></telerik:RadButton>
                    <telerik:RadDropDownList ID="ddlCoatingTypeList" runat="server" AutoPostBack="True" DataSourceID="sqlCoatingType"
                        DataTextField="COATING_TYPE" DataValueField="COATING_TYPE_ID" AppendDataBoundItems="true"
                        OnDataBinding="ddlCoatingTypeList_DataBinding" Width="200px">
                    </telerik:RadDropDownList>
                    <telerik:RadButton ID="btnImport" Text="Bulk Import" Width="110px" runat="server" OnClick="btnImport_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnCoatingType" Text="Coating Types" Width="120px" runat="server"></telerik:RadButton>
                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="200px" EmptyMessage="Search..." AutoPostBack="true">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" DataSourceID="itemsDataSource" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
            MasterTableView-EditMode="InPlace" CellSpacing="-1">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" AllowPaging="true" PageSize="20" DataKeyNames="JC_ID">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Confirm Delete" ConfirmTextFormatString="Are you sure you want to delete {0} ?"
                        ConfirmTextFields="COAT_JC_NO">
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="COAT_JC_NO" FilterControlAltText="Filter COAT_JC_NO column" HeaderText="COAT_JC_NO" SortExpression="COAT_JC_NO" UniqueName="COAT_JC_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="ISSUE DATE">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblIssueDate" Text='<%# Bind("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" SelectedDate='<%# Bind("ISSUE_DATE")%>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="TARGET DATE">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblTargetDate" Text='<%# Bind("TARGET_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadTrgtDatePicker" runat="server" DbSelectedDate='<%# Bind("TARGET_DATE")%>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="SUB_CON_NAME" ReadOnly="true" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="COATING VENDOR" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FROM_SUBCON" ReadOnly="true" FilterControlAltText="Filter FROM_SUBCON column" HeaderText="FROM SUBCON" SortExpression="SUB_CON_NAME" UniqueName="FROM_SUBCON">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="COATING TYPE">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblCoatingType" Text='<%# Bind("COATING_TYPE") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlEditCoatingType" runat="server" DataSourceID="sqlCoatingType"
                                DataTextField="COATING_TYPE" DataValueField="COATING_TYPE_ID" SelectedValue='<%# Bind("TYPE_ID") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="CATEGORY">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblCoatingCat" Text='<%# Bind("COATING_CAT") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlEditCoatingCat" runat="server" SelectedValue='<%# Bind("COATING_CAT") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                    <telerik:DropDownListItem Text="INTERNAL" Value="INTERNAL" />
                                    <telerik:DropDownListItem Text="EXTERNAL" Value="EXTERNAL" />
                                    <telerik:DropDownListItem Text="INTERNAL & EXTERNAL" Value="INTERNAL & EXTERNAL" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="CREATE_BY" ReadOnly="true" FilterControlAltText="Filter CREATE_BY column" HeaderText="CREATE_BY" SortExpression="CREATE_BY" UniqueName="CREATE_BY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <div style="background-color: whitesmoke; margin-top: 3px">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnUpdateTransfer" runat="server" Text="Prepare Transfer Request" Width="200px"
                        OnClick="btnUpdateTransfer_Click">
                    </telerik:RadButton>
                </td>
                <td style="text-align: right">
                    <telerik:RadDropDownList ID="ddlReportType" runat="server" Width="250px" ExpandDirection="Up">
                        <Items>
                            <telerik:DropDownListItem Text="(Select Report)" Value="" />
                            <telerik:DropDownListItem Text="01. Spool List For Coating" Value="51" />
                            <telerik:DropDownListItem Text="02. Material List" Value="52" />
                            <telerik:DropDownListItem Text="03. Spool Transfer Request" Value="53" />
                            <telerik:DropDownListItem Text="04. Material List - Spool wise" Value="52.1" />
                        </Items>
                    </telerik:RadDropDownList>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="100px" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>

    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGalvJobcardTableAdapters.VIEW_ADAPTER_COATING_JCTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="ddlCoatingTypeList" DefaultValue="-1" Name="TYPE_ID" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="XXX" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="COAT_JC_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="TYPE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="TARGET_DATE" Type="DateTime" />
            <asp:Parameter Name="COATING_CAT" Type="String" />
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlCoatingType" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM PIP_COATING_TYPE"></asp:SqlDataSource>
</asp:Content>

