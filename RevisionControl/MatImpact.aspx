<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatImpact.aspx.cs" Inherits="Material_Reports_JC_MIV" Title="Mat Impact" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= rowsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=rowsGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: gainsboro">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnRegister" runat="server" Text="New" Width="80" OnClick="btnRegister_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" Visible="false" OnClick="btnSave_Click" ValidationGroup="submit"></telerik:RadButton>
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
                    <telerik:RadDropDownList ID="cboSpool" runat="server" AppendDataBoundItems="True" DataSourceID="spoolDataSource"
                        DataTextField="SHEET_SPOOL" DataValueField="SPL_ID" Width="143px" OnDataBinding="cboSpool_DataBinding" ValidationGroup="submit">
                        <Items>
                            <telerik:DropDownListItem Value="-1" Text="(Select)" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="spoolValidator" runat="server" ControlToValidate="cboSpool"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator></td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">Revision/ SCR/ FCR</td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <telerik:RadTextBox ID="txtRevNo" runat="server" Width="50"></telerik:RadTextBox>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtSCR" runat="server" Width="50"></telerik:RadTextBox>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtFCR" runat="server" Width="50"></telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">
                    <asp:Label ID="Label1" runat="server" Text="Material Code"></asp:Label></td>
                <td>
                    <telerik:RadDropDownList ID="ddMatCode" runat="server" Width="200px" DataSourceID="ItemCodeDataSource" DataTextField="MAT_CODE1" DataValueField="MAT_ID" OnDataBinding="ddMatCode_DataBinding" ValidationGroup="submit">
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="ItemCodeValidator" runat="server" ControlToValidate="ddMatCode"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">
                    <asp:Label ID="Label2" runat="server" Text="Impact"></asp:Label></td>
                <td>
                    <telerik:RadDropDownList ID="cboImpact" runat="server" AppendDataBoundItems="True" DataSourceID="impactCodeDataSource"
                        DataTextField="IMPACT_CODE" DataValueField="LOM_IMPACT" Width="136px">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke;">
                    <asp:Label ID="Label4" runat="server" Text="S/F"></asp:Label></td>
                <td style="height: 29px">
                    <telerik:RadDropDownList ID="cboSF" runat="server" AppendDataBoundItems="True" DataSourceID="sfDataSource"
                        DataTextField="CAT_NAME" DataValueField="CAT_ID" Width="98px" ValidationGroup="submit">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">
                    <asp:Label ID="Label5" runat="server" Text="Quantity"></asp:Label></td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server" Width="63px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="submit"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 140px; background-color: WhiteSmoke">
                    <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label></td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="436px"></telerik:RadTextBox></td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            PageSize="30" Width="100%" DataSourceID="impactDataSource" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
            DataKeyNames="IMPACT_ID" OnRowEditing="rowsGridView_RowEditing">
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true" Scrolling-EnableColumnClientFreeze="true"></ClientSettings>
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
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox1" runat="server" Text='<%# Bind("REV_NO") %>' Width="40px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("REV_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="SCR" SortExpression="SCR">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox2" runat="server" Text='<%# Bind("SCR") %>' Width="40px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("SCR") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="FCR" SortExpression="FCR">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox3" runat="server" Text='<%# Bind("FCR") %>' Width="40px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("FCR") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="MAT CODE" SortExpression="MAT_CODE1" ReadOnly="True" />

                    <telerik:GridTemplateColumn HeaderText="IMPACT" SortExpression="IMPACT_CODE">
                        <EditItemTemplate>
                            <asp:DropDownList ID="cboImpact" runat="server" AppendDataBoundItems="True" DataSourceID="impactDataSource"
                                DataTextField="IMPACT_CODE" DataValueField="LOM_IMPACT" SelectedValue='<%# Bind("LOM_IMPACT") %>'
                                Width="92px">
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("IMPACT_CODE") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="SF" SortExpression="CAT_NAME">
                        <EditItemTemplate>
                            <asp:DropDownList ID="cboSF" runat="server" AppendDataBoundItems="True" DataSourceID="sfDataSource"
                                DataTextField="CAT_NAME" DataValueField="CAT_ID" SelectedValue='<%# Bind("SF") %>'
                                Width="55px">
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("CAT_NAME") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="QTY" SortExpression="QTY">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox6" runat="server" Text='<%# Bind("QTY") %>' Width="51px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>


    <asp:ObjectDataSource ID="impactDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsIsomeControlATableAdapters.VIEW_MAT_IMPACTTableAdapter"
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
            <asp:Parameter Name="LOM_IMPACT" Type="Decimal" />
            <asp:Parameter Name="SF" Type="Decimal" />
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_IMPACT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sfDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT CAT_ID, CAT_NAME, REMARKS FROM BOM_CATEGORY ORDER BY CAT_ID"></asp:SqlDataSource>
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
    <asp:SqlDataSource ID="ItemCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_ID, MAT_CODE1 FROM VIEW_BOM_EREC_ITEM WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE1) ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="ISO_HiddenField" DefaultValue="XYZ" Name="ISO_TITLE1" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="impactCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT LOM_IMPACT, IMPACT_CODE  FROM PIP_LOM_IMPACT ORDER BY LOM_IMPACT"></asp:SqlDataSource>
</asp:Content>
