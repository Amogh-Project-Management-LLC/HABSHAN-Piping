<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="FCRI_Items.aspx.cs" Inherits="RevisionControl_FCRI_Items" Title="FCRI" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: gainsboro">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntryMode" runat="server" Text="Entry" Width="80" OnClick="btnEntryMode_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddSpool" runat="server" Text="Save" Width="80" OnClick="btnAddSpool_Click" Visible="False"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="120px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div runat="server" id="EntryTable" visible="false">
        <table>
            <tr>
                <td style="background-color: whitesmoke; width: 120px">Isometric No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtIsome" runat="server" AutoPostBack="True"
                        Width="200px" EmptyMessage="Isometric No">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="background-color: whitesmoke; width: 120px">Spool Pc No
                </td>
                <td>
                    <asp:DropDownList ID="cboNewSpool" runat="server" DataSourceID="SpoolDataSource"
                        DataTextField="SPL_TITLE" DataValueField="SPL_ID" Width="250px">
                    </asp:DropDownList>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboNewSpool" ErrorMessage="*" ForeColor="Red" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="background-color: whitesmoke; width: 120px">Rev</td>
                <td>
                    <asp:TextBox ID="txtRevNo" runat="server" Width="50px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRevNo" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="background-color: whitesmoke; width: 120px">SCR</td>
                <td>
                    <asp:TextBox ID="txtSCR" runat="server" Width="50px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSCR" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="background-color: whitesmoke; width: 120px">FCR</td>
                <td>
                    <asp:TextBox ID="txtFCR" runat="server" Width="50px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtFCR" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="background-color: whitesmoke; width: 120px">Spool Status</td>
                <td>
                    <asp:TextBox ID="txtStatus" runat="server" Width="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="background-color: whitesmoke; width: 120px">Remarks</td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="400px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:GridView ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="FCRI_ID,SPL_ID" DataSourceID="itemsDataSource" SkinID="GridViewSkin"
            PageSize="20" Width="100%" OnDataBound="itemsGridView_DataBound">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                    UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" ReadOnly="true" />
                <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="true" />
                <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="true" />
                <asp:TemplateField HeaderText="Rev No" SortExpression="REV_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("REV_NO") %>' Width="37px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("REV_NO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="FCR No" SortExpression="FCR">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FCR") %>' Width="37px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("FCR") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SCR No" SortExpression="SCR">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SCR") %>' Width="37px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("SCR") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="SPL_STATUS" HeaderText="Spool Status" SortExpression="SPL_STATUS" />
                <asp:BoundField DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
            </Columns>
        </asp:GridView>
    </div>

    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>

                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsIsomeControlBTableAdapters.VIEW_FCRI_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_FCRI_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="REV_NO" Type="String" />
            <asp:Parameter Name="SCR" Type="String" />
            <asp:Parameter Name="FCR" Type="String" />
            <asp:Parameter Name="SPL_STATUS" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_FCRI_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="FCRI_ID" QueryStringField="FCRI_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPL_TITLE FROM VIEW_SPOOL_TITLE WHERE (PROJ_ID = :PROJ_ID) AND (ISO_TITLE1 = :ISO_TITLE1) ORDER BY SPL_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="XYZW" Name="ISO_TITLE1" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="scIdField" runat="server" />
</asp:Content>