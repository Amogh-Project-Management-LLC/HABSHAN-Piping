<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStockRegister.aspx.cs" Inherits="Erection_ErectionRepRegister"
    Title="Material - New" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke; padding: 3px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <div>
        <asp:Panel ID="panel1" runat="server" DefaultButton="btnSubmit">
            <asp:UpdatePanel ID="updatePanel1" runat="server">
                <ContentTemplate>
                    <table style="width: 100%" class="TableStyle">
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">Material Code1
                            </td>
                            <td>

                                <telerik:RadTextBox ID="txtMatCode1" runat="server" Width="200px"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="marCode1Validator" runat="server" ControlToValidate="txtMatCode1"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">Material Code2
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtMatCode2" runat="server" Width="200px"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="marCode2Validator" runat="server" ControlToValidate="txtMatCode2"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 200px; background-color: whitesmoke">Size Descriprion
                            </td>
                            <td>
                                <%-- <asp:TextBox ID="txtSizeDesc" runat="server" Width="120px"></asp:TextBox>--%>
                                <%--                    <telerik:RadAutoCompleteBox ID="txtAutoSize" runat="server" Width="120px" DataSourceID="sqlMaterialSource" DataTextField="SIZE_IPMS"
                        DataValueField="SIZE_IPMS" InputType="Text" OnEntryAdded="txtAutoSize_EntryAdded" AutoPostBack="true" BackColor="LightGray"
                        OnTextChanged="txtAutoSize_TextChanged" Filter="StartsWith">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>

                   
                    <asp:RequiredFieldValidator ID="SizeValidator" runat="server" ControlToValidate="txtAutoSize"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                <telerik:RadTextBox ID="txtsizeDesc" Enabled="false" BackColor="LightGray" runat="server" Width="200px"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="SizeValidator" runat="server" ControlToValidate="txtsizeDesc"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">Size1
                            </td>
                            <td>
                                <telerik:RadAutoCompleteBox ID="txtSize1" runat="server" Width="200px" AutoPostBack="true"
                                    Filter="StartsWith" DataSourceID="sqlSizeMaterialSource" DataTextField="size_1" DataValueField="size_1" InputType="Text"
                                    OnTextChanged="txtSize_TextChanged">
                                    <TextSettings SelectionMode="Single" />
                                </telerik:RadAutoCompleteBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">Size2
                            </td>
                            <td> 
                                <telerik:RadAutoCompleteBox ID="txtSize2" runat="server" Width="200px" AutoPostBack="true" 
                                    Filter="StartsWith" DataSourceID="sqlSizeMaterialSource" DataTextField="size_1" DataValueField="size_1" InputType="Text" OnTextChanged="txtSize_TextChanged">
                                    <TextSettings SelectionMode="Single" />
                                </telerik:RadAutoCompleteBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke;">Schedule
                            </td>
                            <td style="height: 26px">
                                <telerik:RadTextBox ID="txtSchDesc" runat="server" Width="200px" Enabled="false" BackColor="LightGray"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="SchValidator" runat="server" ControlToValidate="txtSchDesc"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">Schedule1
                            </td>
                            <td>
                                <telerik:RadAutoCompleteBox ID="txtSch1" runat="server" Width="200px" AutoPostBack="true"
                                    Filter="StartsWith" DataSourceID="sqlSchMaterialSource" DataTextField="schedule" DataValueField="schedule" InputType="Text"
                                    OnTextChanged="txtSch_TextChanged">
                                    <TextSettings SelectionMode="Single" />
                                </telerik:RadAutoCompleteBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">Schedule2
                            </td>
                            <td>
                                <telerik:RadAutoCompleteBox ID="txtSch2" runat="server" Width="200px" AutoPostBack="true"
                                    Filter="StartsWith" DataSourceID="sqlSchMaterialSource" DataTextField="schedule" DataValueField="schedule" InputType="Text"
                                    OnTextChanged="txtSch_TextChanged">
                                    <TextSettings SelectionMode="Single" />
                                </telerik:RadAutoCompleteBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">Length
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtlength" runat="server" Width="200px" Enabled="false" BackColor="LightGray"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">Length 1
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="txtlen1" runat="server" Width="200px" AutoPostBack="true" OnTextChanged="txtlen_TextChanged">
                                    <NumberFormat DecimalDigits="3" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">Length 2
                            </td>
                            <td>
                                <telerik:RadNumericTextBox ID="txtlen2" runat="server" Width="200px" AutoPostBack="true" OnTextChanged="txtlen_TextChanged">
                                    <NumberFormat DecimalDigits="3" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke;">Profile
                            </td>
                            <td style="height: 24px">
                                <telerik:RadDropDownList ID="ddlProfile" runat="server" Width="200px" AppendDataBoundItems="True">
                                    <Items>
                                        <telerik:DropDownListItem Value="" Text="-Select One-" />
                                        <telerik:DropDownListItem Value="BW" Text="BW" />
                                        <telerik:DropDownListItem Value="SW" Text="SW" />
                                        <telerik:DropDownListItem Value="THD" Text="THD" />
                                        <telerik:DropDownListItem Value="PE" Text="PE" />
                                    </Items>

                                </telerik:RadDropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">Bolt Length
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtBoltLength" runat="server" Width="200px"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke;">Type
                            </td>
                            <td style="height: 24px">
                                <telerik:RadDropDownList ID="cboItem" runat="server" DataSourceID="ItemDataSource" DataTextField="ITEM_NAM"
                                    DataValueField="ITEM_ID" Width="200px" AppendDataBoundItems="True">
                                    <Items>
                                        <telerik:DropDownListItem Value="-1" Text="-Select One-" />
                                    </Items>

                                </telerik:RadDropDownList>
                                <asp:CompareValidator ID="itemValidator" runat="server" ControlToValidate="cboItem"
                                    ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke">UOM
                            </td>
                            <td>
                                <telerik:RadDropDownList ID="cboUOM" runat="server" DataSourceID="UomDataSource" DataTextField="UOM"
                                    DataValueField="UNIT_ID" Width="200px" AppendDataBoundItems="True">
                                    <Items>
                                        <telerik:DropDownListItem Value="-1" Text="-Select One-" />
                                    </Items>

                                </telerik:RadDropDownList>
                                <asp:CompareValidator ID="uomValidator" runat="server" ControlToValidate="cboUOM"
                                    ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; background-color: whitesmoke; vertical-align: top;">Description
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtDesc" runat="server" Width="450px" Height="50px" TextMode="MultiLine"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="descValidator" runat="server" ControlToValidate="txtDesc"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
    </div>
 
        <asp:SqlDataSource ID="UomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            EnableViewState="False" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT UNIT_ID,UOM FROM UOM_DESCR ORDER BY UOM"></asp:SqlDataSource>
    <asp:SqlDataSource ID="ItemDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        EnableViewState="False" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ITEM_ID, ITEM_NAM FROM PIP_MAT_ITEM ORDER BY ITEM_NAM"></asp:SqlDataSource>
    <%--<asp:SqlDataSource ID="sqlMaterialSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SIZE_IPMS FROM PIP_SIZE_DESCR"></asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="sqlSizeMaterialSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT size_1 FROM PIP_SIZE_DESCR"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSchMaterialSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SCHEDULE FROM JOINT_SIZE_SCH"></asp:SqlDataSource>

</asp:Content>
