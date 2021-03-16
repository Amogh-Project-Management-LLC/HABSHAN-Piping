<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="WelderQualify.aspx.cs" Inherits="WeldingInspec_WelderQualification"
    Title="Welder Qualification" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= qualifyGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=qualifyGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRegister" runat="server" Text="New" Width="80" OnClick="btnRegister_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <table id="EntryTable" runat="server" visible="false">
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label1" runat="server" Text="WQT No"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtWQT" runat="server" Width="150px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="wqtValidator" runat="server" ControlToValidate="txtWQT"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label2" runat="server" Text="WPS No"></asp:Label>
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboWps" runat="server" AppendDataBoundItems="True" DataSourceID="wpsDataSource"
                        DataTextField="WPS_NO1" DataValueField="WPS_NO1" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Text="(Select WPS)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="wpsValidator" runat="server" ControlToValidate="cboWps"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select WPS)" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label3" runat="server" Text="Material Type"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMatType" runat="server" Width="150px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="matTypeValidator" runat="server" ControlToValidate="txtMatType"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label4" runat="server" Text="Process"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtProcess" runat="server" Width="150px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="processValidator" runat="server" ControlToValidate="txtProcess"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label5" runat="server" Text="Size From"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSizeFrom" runat="server" Width="72px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="sizeFromValidator" runat="server" ControlToValidate="txtThkFrom"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label6" runat="server" Text="Size To"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSizeTo" runat="server" Width="72px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="sizeToValidator" runat="server" ControlToValidate="txtSizeTo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label7" runat="server" Text="Thick From"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtThkFrom" runat="server" Width="72px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="thkFromValidator" runat="server" ControlToValidate="txtThkFrom"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label8" runat="server" Text="Thick To"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtThkTo" runat="server" Width="72px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="ThkToValidator" runat="server" ControlToValidate="txtThkTo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label9" runat="server" Text="Qualify Date"></asp:Label>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtQualifyDate" runat="server" Width="150px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="qualifyDateValidator" runat="server" ControlToValidate="txtQualifyDate"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label10" runat="server" Text="Qualify Position"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQualifyPos" runat="server" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="qualifyGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="WELDER_ID,WPS_NO" DataSourceID="qualifyDataSource" Width="100%" AllowAutomaticDeletes="true"
            AllowAutomaticUpdates="true">
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true"></ClientSettings>
            <MasterTableView EditMode="InPlace" DataSourceID="qualifyDataSource" DataKeyNames="WELDER_ID,WPS_NO">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmText="Delete this Job Card?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridTemplateColumn HeaderText="WQT No" SortExpression="WQT_NO">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox1" runat="server" Text='<%# Bind("WQT_NO") %>' Width="78px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("WQT_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="WPS No" SortExpression="WPS_NO">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="cboWps" runat="server" AppendDataBoundItems="True" DataSourceID="wpsDataSource"
                                DataTextField="WPS_NO1" DataValueField="WPS_NO1" SelectedValue='<%# Bind("WPS_NO") %>'
                                Width="200px">
                                <Items>
                                    <telerik:DropDownListItem Text="" Selected="true" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("WPS_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Material Type" SortExpression="MAT_TYPE">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox3" runat="server" Text='<%# Bind("MAT_TYPE") %>' Width="72px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("MAT_TYPE") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Process" SortExpression="PROCESS">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox4" runat="server" Text='<%# Bind("PROCESS") %>' Width="62px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("PROCESS") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Size From" SortExpression="SIZE_FROM">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox5" runat="server" Text='<%# Bind("SIZE_FROM") %>' Width="43px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("SIZE_FROM") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Size To" SortExpression="SIZE_TO">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox6" runat="server" Text='<%# Bind("SIZE_TO") %>' Width="39px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("SIZE_TO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Thk From " SortExpression="THK_FROM">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox7" runat="server" Text='<%# Bind("THK_FROM") %>' Width="37px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("THK_FROM") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Thk To" SortExpression="THK_TO">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox8" runat="server" Text='<%# Bind("THK_TO") %>' Width="36px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("THK_TO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Qualify Date" SortExpression="QUALIF_DATE">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("QUALIF_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("QUALIF_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Qualify Pos" SortExpression="QUALIF_POS">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="TextBox9" runat="server" Text='<%# Bind("QUALIF_POS") %>' Width="86px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("QUALIF_POS") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="qualifyDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsWeldersTableAdapters.PIP_WELDER_QUALIFYTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="Original_WPS_NO" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="WQT_NO" Type="String" />
            <asp:Parameter Name="WPS_NO" Type="String" />
            <asp:Parameter Name="MAT_TYPE" Type="String" />
            <asp:Parameter Name="PROCESS" Type="String" />
            <asp:Parameter Name="SIZE_FROM" Type="Decimal" />
            <asp:Parameter Name="SIZE_TO" Type="Decimal" />
            <asp:Parameter Name="THK_FROM" Type="Decimal" />
            <asp:Parameter Name="THK_TO" Type="Decimal" />
            <asp:Parameter Name="QUALIF_POS" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="Original_WPS_NO" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WELDER_ID" QueryStringField="WELDER_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="wpsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WPS_NO1
FROM PIP_WPS_NO
WHERE (PROJECT_ID = :PROJECT_ID)
ORDER BY WPS_NO1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
