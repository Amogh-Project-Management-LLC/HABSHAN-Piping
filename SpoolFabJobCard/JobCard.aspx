<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="JobCard.aspx.cs" Inherits="Material_FabricationJobCard" Title="JobCard" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= jcGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth;
            grid.get_element().style.height = (height) - document.getElementById("grad").clientHeight - document.getElementById("MasterHeader").clientHeight
                - document.getElementById("headerButtons").clientHeight - document.getElementById("FooterButtons").clientHeight
                - document.getElementById("MasterFooter").clientHeight - 20 + "px";
            grid.get_element().style.width = width - 25 + "px";
            grid.get_element()
            grid.repaint();
        }
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= jcGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
    </script>
    <div id="headerButtons">
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewJC" runat="server" Text="New" Width="80" ></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewSpools" runat="server" Text="Spools" Width="80" OnClick="btnViewSpools_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSelectSpls" runat="server" Text="Select Spools" Width="110" OnClick="btnSelectSpls_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnCollectPDFs" runat="server" Text="Download PDFs" Width="140px" OnClick="btnCollectPDFs_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnBulkImportSpl" runat="server" Text="Bulk Import" Width="140" OnClick="btnBulkImportSpl_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                        EmptyMessage="Search Here" Width="200px" AutoPostBack="True">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadButton ID="btnJC_Plate" runat="server" Visible="false" Text="Plates" Width="80" OnClick="btnJC_Plate_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnUpdatePlateMTO" runat="server" Visible="false" Text="Update Plate" Width="110px" OnClick="btnUpdatePlateMTO_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadDropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="140px">
                    </telerik:RadDropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="jcGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="WO_ID" DataSourceID="jcDataSource" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
            PageSize="30" Width="100%" OnRowUpdating="jcGridView_RowUpdating" OnDataBound="jcGridView_DataBound" OnItemCommand="jcGridView_ItemCommand">
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
             <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView EditMode="InPlace" DataSourceID="jcDataSource" DataKeyNames="WO_ID">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmText="Delete this Job Card?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="WO_TYPE" HeaderText="JC Type" SortExpression="WO_TYPE" ReadOnly="true" />

                    <telerik:GridTemplateColumn HeaderText="Mat Type" SortExpression="MAT_TYPE">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddMainMat" runat="server" AppendDataBoundItems="True" DataSourceID="MaterialDataSource"
                                DataTextField="MAT_GROUP" DataValueField="MAT_GROUP" SelectedValue='<%# Bind("MAT_TYPE") %>'
                                Width="126px">
                                <Items>
                                    <telerik:DropDownListItem Selected="true" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblMainMat" runat="server" Text='<%# Bind("MAT_TYPE") %>' Width="126px"></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Job Card No" SortExpression="WO_NAME" ReadOnly="true">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("WO_NAME") %>' Width="150px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("WO_NAME") %>' Width="200px"></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Rev" SortExpression="REVISION">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("REVISION") %>' Width="30px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle Width="50px" />
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("REVISION") %>' Width="15px"></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="REV_DATE" DataType="System.DateTime" FilterControlAltText="Filter REV_DATE column" HeaderText="Revision Date" SortExpression="REV_DATE" UniqueName="REV_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtRevDateEdit" runat="server" SelectedDate='<%# Bind("REV_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RevLabel" runat="server" Text='<%# Eval("REV_DATE", "{0:dd-MMM-yyyy}") %>' Width="100px"></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>


                    <telerik:GridTemplateColumn HeaderText="Issued Date" SortExpression="ISSUE_DATE">
                        <ItemStyle Width="100px" />
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>' Width="80px"></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="TARGET_CMPLT" DataType="System.DateTime" FilterControlAltText="Filter TARGET_CMPLT column" HeaderText="Target Complete" SortExpression="TARGET_CMPLT" UniqueName="TARGET_CMPLT">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtTargetEdit" runat="server" SelectedDate='<%# Bind("TARGET_CMPLT") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="TargetLabel" runat="server" Text='<%# Eval("TARGET_CMPLT", "{0:dd-MMM-yyyy}") %>' Width="120px"></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>


                    <telerik:GridTemplateColumn HeaderText="Sub Contractor" SortExpression="SUB_CON_NAME" ReadOnly="true">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="subconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SUB_CON_ID") %>'
                                Width="120px" AppendDataBoundItems="True">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Paint Code" SortExpression="PAINT_CODE">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox7" runat="server" Text='<%# Bind("PAINT_CODE") %>' Width="50px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadLabel ID="Label3" runat="server" Text='<%# Bind("PAINT_CODE") %>'></telerik:RadLabel>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div id="FooterButtons">
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>

                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="cboReports" runat="server" Width="300px">
                        <asp:ListItem Selected="True" Value="2">Spool Piece List For Fabrication</asp:ListItem>
                        <asp:ListItem Value="1">Material List - Summary (MIVR)</asp:ListItem>
                        <asp:ListItem Value="5">Material List - Spool Wise</asp:ListItem>
                        <asp:ListItem Value="5.1">Pipe Cut List - Spool Wise</asp:ListItem>
                        <asp:ListItem Value="3">Spool Piece List For Paint</asp:ListItem>
                        <%--<asp:ListItem Value="1">Pick Ticket - Overall</asp:ListItem>--%>
                        <asp:ListItem Value="1.1">Pick Ticket - Pipes</asp:ListItem>
                        <asp:ListItem Value="1.2">Pick Ticket - Fitting</asp:ListItem>
                        <%--   <asp:ListItem Value="6">Plate Summary</asp:ListItem>--%>
                        <asp:ListItem Value="7">Welding</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:ObjectDataSource ID="jcDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsFabricationJCTableAdapters.PIP_WORK_ORDTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_WO_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <%--<asp:Parameter Name="WO_NAME" Type="String" />--%>
            <%--<asp:Parameter Name="SUB_CON_ID" Type="Decimal" />--%>
            <%--<asp:Parameter Name="ISSUE_DATE" Type="DateTime" />--%>
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="REVISION" Type="String" />
            <asp:Parameter Name="TARGET_CMPLT" Type="DateTime" />
            <asp:Parameter Name="REV_DATE" Type="DateTime" />
            <asp:Parameter Name="MAT_TYPE" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_WO_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="subconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID,SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MaterialDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT DISTINCT MAT_GROUP FROM PIP_MAT_TYPE WHERE (PROJ_ID = :PROJECT_ID) ORDER BY MAT_GROUP'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
