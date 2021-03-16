<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TC_Index.aspx.cs" Inherits="HeatNo_TC_Index" Title="MTC" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnShowPDF" runat="server" Text="PDF" Width="80"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnUpload" runat="server" Text="Upload PDF" Width="100" OnClick="btnUpload_Click" Enabled="False"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtFilter" runat="server" OnTextChanged="txtFilter_TextChanged"
                        EmptyMessage="Search Here" Width="160px" AutoPostBack="true">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="120px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="tcGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="tcDataSource" PageSize="12" DataKeyNames="TC_ID" SkinID="GridViewSkin"
            Width="100%" OnRowEditing="tcGridView_RowEditing" OnDataBound="tcGridView_DataBound"
            OnSelectedIndexChanged="tcGridView_SelectedIndexChanged">
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView DataKeyNames="TC_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridTemplateColumn HeaderText="TC Number" SortExpression="TC_CODE">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TC_CODE") %>' Width="101px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("TC_CODE") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="PO Number" SortExpression="PO_NO">
                        <EditItemTemplate>
                            <asp:DropDownList ID="poDropDownList" runat="server" AppendDataBoundItems="True"
                                DataSourceID="poDataSource" DataTextField="PO_NO" DataValueField="PO_ID" Font-Size="90%"
                                SelectedValue='<%# Bind("PO_ID") %>' Width="210px">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("PO_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Remarks" SortExpression="REMARKS">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("REMARKS") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDetails" runat="server" Text="Details" Width="80" OnClick="btnHeatNos_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddTC" runat="server" Text="New" Width="80" OnClick="btnAddTC_Click"></telerik:RadButton>
                </td>
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
    <asp:ObjectDataSource ID="tcDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsGeneralTableAdapters.PIP_TEST_CARDSTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_TC_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TC_CODE" Type="String" />
            <asp:Parameter Name="PO_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_TC_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtFilter" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="poDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID, PO_NO FROM PIP_PO WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY PO_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
