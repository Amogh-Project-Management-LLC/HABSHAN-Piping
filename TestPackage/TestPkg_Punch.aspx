<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TestPkg_Punch.aspx.cs" Inherits="TestPkg_Punch" Title="Punch List" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: whitesmoke">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" Width="84px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnHideEnt" runat="server" Text="Entry" Width="80px" CausesValidation="False" OnClick="btnHideEnt_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Save" Width="80px" Visible="False" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%" class="TableStyle" id="EntryTable" runat="server" visible="false">
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">Item No
                        </td>
                        <td>
                            <asp:TextBox ID="txtItem" runat="server" Width="80px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="itemValidator" runat="server" ErrorMessage="*" ControlToValidate="txtItem"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">Category
                        </td>
                        <td>
                            <asp:DropDownList ID="cboCat" runat="server" DataSourceID="catDataSource" DataTextField="PUNCH_CAT"
                                DataValueField="PUNCH_CAT" Width="80px">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="catValidator" runat="server" ErrorMessage="*" ControlToValidate="cboCat"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">Originator
                        </td>
                        <td>
                            <asp:DropDownList ID="cboOrgn" runat="server" DataSourceID="originDataSource" DataTextField="ORIGINATOR"
                                DataValueField="ORIGIN_ID" Width="200px">
                                <asp:ListItem Value="-1">(Select One)</asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="orgnValidator" runat="server" ErrorMessage="*" ControlToValidate="cboOrgn"
                                Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">Isometric No
                        </td>
                        <td>
                            <asp:TextBox ID="txtIsome" runat="server" Width="200px" OnTextChanged="txtIsome_TextChanged"
                                AutoPostBack="True"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="isomeValidator" runat="server" ErrorMessage="*" ControlToValidate="txtIsome"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">Sheet
                        </td>
                        <td>
                            <asp:DropDownList ID="cboSheet" runat="server" DataSourceID="sheetDataSource" DataTextField="SHEET"
                                DataValueField="SHEET" Width="100px">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="sheetValidator" runat="server" ErrorMessage="*" ControlToValidate="cboSheet"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">Description
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" Width="500px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="remValidator" runat="server" ErrorMessage="*" ControlToValidate="txtRemarks"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <telerik:RadGrid ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataKeyNames="TPK_ID,ITEM_NO" DataSourceID="itemsDataSource"
                    PageSize="15" Width="100%">
                    <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                    <MasterTableView DataKeyNames="TPK_ID,ITEM_NO" AllowAutomaticUpdates="true" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="20px" />
                            </telerik:GridEditCommandColumn>
                            
                            <telerik:GridTemplateColumn HeaderText="Item No" SortExpression="ITEM_NO">
                                <edititemtemplate>
                                <asp:TextBox ID="ItemNoTextBox" runat="server" Text='<%# Bind("ITEM_NO") %>' Width="42px"></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("ITEM_NO") %>'></asp:Label>
                            </itemtemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Category" SortExpression="PUNCH_CAT">
                                <edititemtemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="catDataSource"
                                    DataTextField="PUNCH_CAT" DataValueField="PUNCH_CAT" SelectedValue='<%# Bind("PUNCH_CAT") %>'
                                    Width="51px">
                                </asp:DropDownList>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("PUNCH_CAT") %>'></asp:Label>
                            </itemtemplate>
                            </telerik:GridTemplateColumn>                            
                            <telerik:GridBoundColumn DataField="PUNCH_CODE" HeaderText="Punch Code" SortExpression="PUNCH_CODE" />
                            <telerik:GridTemplateColumn HeaderText="ORIGINATOR" SortExpression="ORIGINATOR">
                                <edititemtemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="originDataSource"
                                    DataTextField="ORIGINATOR" DataValueField="ORIGIN_ID" SelectedValue='<%# Bind("ORIGIN_ID") %>'
                                    Width="105px">
                                </asp:DropDownList>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("ORIGINATOR") %>'></asp:Label>
                            </itemtemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet No" SortExpression="SHEET" />
                            <telerik:GridTemplateColumn HeaderText="Target Clear Date" SortExpression="TARGET_CLEAR_DATE">
                                <edititemtemplate>
                                <asp:TextBox ID="TextBox61" runat="server" Text='<%# Bind("TARGET_CLEAR_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="76px"></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label71" runat="server" Text='<%# Bind("TARGET_CLEAR_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </itemtemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Clear Date" SortExpression="CLEAR_DATE">
                                <edititemtemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("CLEAR_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="76px"></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("CLEAR_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </itemtemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Description" SortExpression="ITEM_DESC">
                                <edititemtemplate>
                                <asp:TextBox ID="TextBox1" Width="98%" runat="server" Text='<%# Bind("ITEM_DESC") %>'></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("ITEM_DESC") %>'></asp:Label>
                            </itemtemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td style="background-color: whitesmoke;">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" Width="80px" CausesValidation="False" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="44px"
                                CausesValidation="False" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" EnableViewState="False" Text="No" Visible="False" Width="44px" CausesValidation="False" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsTestPkg_ATableAdapters.VIEW_TPK_PUNCHTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TPK_ID" Type="Decimal" />
            <asp:Parameter Name="Original_ITEM_NO" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ITEM_NO" Type="String" />
            <asp:Parameter Name="PUNCH_CAT" Type="String" />
            <asp:Parameter Name="ORIGIN_ID" Type="Decimal" />
            <asp:Parameter Name="SHEET" Type="String" />
            <asp:Parameter Name="CLEAR_DATE" Type="DateTime" />
            <asp:Parameter Name="PUNCH_CODE" Type="String" />
            <asp:Parameter Name="ITEM_DESC" Type="String" />
            <asp:Parameter Name="TARGET_CLEAR_DATE" Type="DateTime" />
            <asp:Parameter Name="Original_TPK_ID" Type="Decimal" />
            <asp:Parameter Name="Original_ITEM_NO" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TPK_ID" QueryStringField="TPK_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="originDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ORIGIN_ID, ORIGINATOR FROM TPK_ORIGINATOR ORDER BY ORIGIN_ID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="catDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PUNCH_CAT FROM TPK_PUNCH_CAT ORDER BY PUNCH_CAT"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sheetDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SHEET FROM PIP_SPOOL WHERE (ISO_ID = :ISO_ID) ORDER BY SHEET">
        <SelectParameters>
            <asp:ControlParameter ControlID="ISO_ID_Field" DefaultValue="-1" Name="ISO_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="ISO_ID_Field" runat="server" />
</asp:Content>
