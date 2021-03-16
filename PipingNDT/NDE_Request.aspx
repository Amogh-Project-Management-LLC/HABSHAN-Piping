<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_Request.aspx.cs" Inherits="WeldingInspec_NDE_Request" Title="NDT Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
     </script>
    <div>
        <table style="width: 100%;">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <telerik:RadDropDownList ID="ddNDE_Type" runat="server" DataSourceID="ndetypeDataSource" DataTextField="NDE_TYPE" DataValueField="NDE_TYPE_ID" Width="120px"
                                AppendDataBoundItems="True" AutoPostBack="True" OnDataBinding="ddNDE_Type_DataBinding" OnDataBound="ddNDE_Type_DataBound" OnSelectedIndexChanged="ddNDE_Type_SelectedIndexChanged">
                            </telerik:RadDropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <asp:ImageButton ID="ImageButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" />
                </td>
                <td>
                    <telerik:RadButton ID="btnBulkImport" runat="server" Text="BulkRequest\Update" Width="150" OnClick="btnBulkImport_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnView" runat="server" Text="Joints" Width="80" OnClick="btnView_Click"></telerik:RadButton>
                </td>


                <td>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <asp:HyperLink ID="HyperLinkPreview" runat="server" ImageUrl="~/Images/icons/printer.png" Target="_blank"></asp:HyperLink>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <asp:HyperLink ID="HyperLinkPreview2" runat="server" ImageUrl="~/Images/icons/printer.png" Target="_blank"></asp:HyperLink>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td style="text-align: right; width: 100%">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <telerik:RadTextBox ID="txtFilter" runat="server" Width="150" OnTextChanged="txtFilter_TextChanged" EmptyMessage="Search Here" AutoPostBack="True"></telerik:RadTextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="NdeReqDataSource"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" OnUpdateCommand="RadGrid1_UpdateCommand" 
                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="True" >
               <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                <ClientSettings  EnablePostBackOnRowClick="True">
                    <Selecting AllowRowSelect="True"></Selecting>
                    <Scrolling AllowScroll="True" UseStaticHeaders="True" FrozenColumnsCount="3"></Scrolling>
                  </ClientSettings>
                <ClientSettings AllowKeyboardNavigation="true">
                    <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                        AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                </ClientSettings>
                <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataKeyNames="NDE_REQ_ID" DataSourceID="NdeReqDataSource" HierarchyLoadMode="Client" PageSize="15">
                    <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                    
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                            <ItemStyle Width="50px" />
                            <HeaderStyle Width="50px" />
                        </telerik:GridEditCommandColumn>

                        <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" >
                            <ItemStyle Width="50px" />
                            <HeaderStyle Width="50px" />
                        </telerik:GridButtonColumn>

                        <telerik:GridBoundColumn DataField="NDE_REQ_NO" FilterControlAltText="Filter NDE_REQ_NO column" HeaderText="Request No" SortExpression="NDE_REQ_NO" UniqueName="NDE_REQ_NO" AutoPostBackOnFilter="true">
                               <ItemStyle Width="140px" />
                            <HeaderStyle Width="140px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NDE_TYPE" FilterControlAltText="Filter NDE_TYPE column" HeaderText="NDE Type" SortExpression="NDE_TYPE" UniqueName="NDE_TYPE" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                               <ItemStyle Width="80px" />
                            <HeaderStyle Width="80px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn DataField="ISSUE_DATE" DataType="System.DateTime" FilterControlAltText="Filter ISSUE_DATE column" HeaderText="Issue Date" SortExpression="ISSUE_DATE"
                            UniqueName="ISSUE_DATE" DataFormatString="{0:dd-MMM-yyyy}" EditDataFormatString="dd-MMM-yyyy" AutoPostBackOnFilter="true" 
                            FilterControlWidth="80px" >
                               <ItemStyle Width="140px" />
                            <HeaderStyle Width="140px" />
                        </telerik:GridDateTimeColumn>

                        <telerik:GridTemplateColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="Subcon"
                            SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                            <ItemTemplate>
                                <asp:Label ID="LabelSubconEdit" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownListSubconEdit" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                                    Width="150px">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                               <ItemStyle Width="140px" />
                            <HeaderStyle Width="140px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                               <ItemStyle Width="140px" />
                            <HeaderStyle Width="140px" />
                        </telerik:GridBoundColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
                <GroupingSettings CaseSensitive="false" />
            </telerik:RadGrid>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:ObjectDataSource ID="NdeReqDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsNDETableAdapters.VIEW_ADAPTER_NDETableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="ddNDE_Type" DefaultValue="-1" Name="NDE_TYPE_ID" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="txtFilter" Name="FILTER" PropertyName="Text" Type="String" DefaultValue="%" />

        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="NDE_REQ_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_NDE_REQ_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_NDE_REQ_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="ndetypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT NDE_TYPE_ID, NDE_TYPE FROM PIP_NDE_TYPE ORDER BY NDE_TYPE'></asp:SqlDataSource>
</asp:Content>
