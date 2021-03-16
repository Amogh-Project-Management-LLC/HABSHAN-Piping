<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="WeldImpact.aspx.cs" Inherits="Material_Reports_JC_MIV" Title="Untitled Page" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnRegister" runat="server" Text="New" Width="80" OnClick="btnRegister_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" Visible="false" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server"
                        EmptyMessage="Search.." AutoPostBack="True" Width="200px">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div runat="server" id="EntryDiv" visible="false">
        <table>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">Isometric No</td>
                <td>

                    <telerik:RadSearchBox ID="RadSearchBoxISO" runat="server" Width="250px" EmptyMessage="Search Here" DropDownSettings-Height="300"
                        DataSourceID="SearchBoxDataSource" DataTextField="ISO_TITLE1" DataValueField="ISO_TITLE1" ShowSearchButton="false"
                        OnSearch="RadSearchBoxISO_Search">
                    </telerik:RadSearchBox>
                </td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">
                    <asp:Label ID="Label7" runat="server" Text="Spool/ Erec Page"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="cboSpool" runat="server" AppendDataBoundItems="True" DataSourceID="spoolDataSource"
                        DataTextField="SHEET_SPOOL" DataValueField="SPL_ID" Width="143px" OnDataBinding="cboSpool_DataBinding">
                        <asp:ListItem Value="-1">-Select-</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="spoolValidator" runat="server" ControlToValidate="cboSpool"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator></td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">Revision/SCR/FCR</td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtRevNo" runat="server" Width="40px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="txtSCR" runat="server" Width="40px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFCR" runat="server" Width="40px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">
                    <asp:Label ID="Label1" runat="server" Text="Joint No"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtJointNo" runat="server" Width="68px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="jointValidator" runat="server" ControlToValidate="txtJointNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">
                    <asp:Label ID="Label10" runat="server" Text="Joint Revision"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="cboRevision" runat="server" DataSourceID="revDataSource" DataTextField="SYMBOL"
                        DataValueField="JNT_REV_ID" Width="295px">
                    </asp:DropDownList><asp:CompareValidator ID="revCodeValidator" runat="server" ControlToValidate="cboRevision"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator></td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">
                    <asp:Label ID="Label2" runat="server" Text="Old Category"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="cboOldCat" runat="server" Width="74px">
                        <asp:ListItem Value="S">Shop</asp:ListItem>
                        <asp:ListItem Value="F">Field</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">
                    <asp:Label ID="Label8" runat="server" Text="New Category"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="cboNewCat" runat="server" Width="74px">
                        <asp:ListItem Value="S">Shop</asp:ListItem>
                        <asp:ListItem Value="F">Field</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">
                    <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="436px"></asp:TextBox></td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            PageSize="18" Width="100%" DataSourceID="impactDataSource" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
            DataKeyNames="IMPACT_ID" OnRowEditing="rowsGridView_RowEditing">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataSourceID="impactDataSource" DataKeyNames="IMPACT_ID" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmText="Delete? {0}" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric" SortExpression="ISO_TITLE1" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="True" />
                    <telerik:GridTemplateColumn HeaderText="Rev No" SortExpression="REV_NO">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox15" runat="server" Text='<%# Bind("REV_NO") %>' Width="40px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label15" runat="server" Text='<%# Bind("REV_NO") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="SCR" SortExpression="SCR">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox25" runat="server" Text='<%# Bind("SCR") %>' Width="40px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label25" runat="server" Text='<%# Bind("SCR") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="FCR" SortExpression="FCR">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox35" runat="server" Text='<%# Bind("FCR") %>' Width="40px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label45" runat="server" Text='<%# Bind("FCR") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="JOINT NO" SortExpression="JOINT_NO">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("JOINT_NO") %>' Width="46px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("JOINT_NO") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Joint Rev" SortExpression="SYMBOL">
                        <edititemtemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="revDataSource"
                            DataTextField="SYMBOL" DataValueField="JNT_REV_ID" SelectedValue='<%# Bind("JNT_REV_ID") %>'
                            Width="54px">
                        </asp:DropDownList>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("SYMBOL") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="OLD CAT" SortExpression="OLD_CAT">
                        <edititemtemplate>
                        <asp:DropDownList ID="cboOldCat" runat="server" SelectedValue='<%# Bind("OLD_CAT") %>'
                            Width="59px">
                            <asp:ListItem Value="S">Shop</asp:ListItem>
                            <asp:ListItem Value="F">Field</asp:ListItem>
                        </asp:DropDownList>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("OLD_CAT") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="NEW CAT" SortExpression="NEW_CAT">
                        <edititemtemplate>
                        <asp:DropDownList ID="cboNewCat" runat="server" SelectedValue='<%# Bind("NEW_CAT") %>'
                            Width="63px">
                            <asp:ListItem Value="S">Shop</asp:ListItem>
                            <asp:ListItem Value="F">Field</asp:ListItem>
                        </asp:DropDownList>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("NEW_CAT") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

   
    <asp:ObjectDataSource ID="impactDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsIsomeControlATableAdapters.VIEW_WELD_IMPACTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_IMPACT_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH_TEXT" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REV_NO" Type="String" />
            <asp:Parameter Name="SCR" Type="String" />
            <asp:Parameter Name="FCR" Type="String" />
            <asp:Parameter Name="JOINT_NO" Type="String" />
            <asp:Parameter Name="JNT_REV_ID" Type="Decimal" />
            <asp:Parameter Name="OLD_CAT" Type="String" />
            <asp:Parameter Name="NEW_CAT" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_IMPACT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="revDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JNT_REV_ID, SYMBOL FROM PIP_JOINT_REV ORDER BY SYMBOL"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SearchBoxDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_TITLE1 FROM PIP_ISOMETRIC WHERE (PROJ_ID = :PROJECT_ID) ORDER BY ISO_TITLE1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="ISO_HiddenField" runat="server" />
    <asp:SqlDataSource ID="spoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SHEET_SPOOL FROM VIEW_SPOOL_TITLE WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE1) ORDER BY SHEET, SPOOL">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="ISO_HiddenField" DefaultValue="XYZ" Name="ISO_TITLE1" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
