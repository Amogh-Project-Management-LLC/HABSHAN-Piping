<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="JC_MIV_Rndlens.aspx.cs" Inherits="JC_MIV_RndLens" Title="Jobcard MIV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80" OnClick="btnEntry_Click"></telerik:RadButton>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    PageSize="18" Width="100%" DataSourceID="itemsDataSource" SkinID="GridViewSkin"
                    DataKeyNames="WO_ID,MAT_ID">
                    <Columns>
                        <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                            SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                            UpdateImageUrl="~/Images/icon-save.gif">
                            <ItemStyle Width="50px" />
                        </asp:CommandField>
                        <asp:BoundField DataField="MAT_CODE1" HeaderText="Material Code" ReadOnly="True" SortExpression="MAT_CODE1" />
                        <asp:BoundField DataField="SIZE_DESC" HeaderText="Size" ReadOnly="True" SortExpression="SIZE_DESC" />
                        <asp:BoundField DataField="WALL_THK" HeaderText="Sched" ReadOnly="True" SortExpression="WALL_THK" />
                        <asp:BoundField DataField="MAT_TYPE" HeaderText="Material Type" ReadOnly="True" SortExpression="MAT_TYPE" />
                        <asp:BoundField DataField="UOM" HeaderText="UOM" ReadOnly="True" SortExpression="UOM" />
                        <asp:TemplateField HeaderText="Random Len" SortExpression="RND_LEN">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RND_LEN") %>' Width="51px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("RND_LEN") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Allowance Qty" SortExpression="ALW_QTY">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ALW_QTY") %>' Width="52px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("ALW_QTY") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Weld Gap" SortExpression="WELD_GAP">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("WELD_GAP") %>' Width="52px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("WELD_GAP") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div style="background-color: whitesmoke;">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click" Skin="Sunset"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50" OnClick="btnYes_Click" EnableViewState="false" Visible="false" Skin="Sunset"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50" EnableViewState="false" Visible="false" Skin="Telerik"></telerik:RadButton>
                        </td>
                        <td style="width: 100%; text-align: right;">
                            <asp:DropDownList ID="cboMat" runat="server" AppendDataBoundItems="True" DataSourceID="matDataSource"
                                DataTextField="MAT_CODE1" DataValueField="MAT_ID" Width="350px" Visible="False" OnDataBinding="cboMat_DataBinding">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnInsert" runat="server" Text="Save" Width="80" OnClick="btnInsert_Click" Visible="False"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnAddAllPipes" runat="server" Text="Save All" Width="110" OnClick="btnAddAllPipes_Click" Visible="False"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsCuttingPlanTableAdapters.PIP_WORK_ORD_CUTLEN_RNDLENTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_WO_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="RND_LEN" Type="Decimal" />
            <asp:Parameter Name="ALW_QTY" Type="Decimal" />
            <asp:Parameter Name="WELD_GAP" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_WO_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WO_ID" QueryStringField="WO_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="matDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_ID, MAT_CODE1
FROM VIEW_JC_MAT_SUMMARY WHERE (WO_ID = :WO_ID) AND (ITEM_NAM = 'PIPE')
AND (MAT_ID NOT IN (SELECT MAT_ID FROM PIP_WORK_ORD_CUTLEN_RNDLEN WHERE WO_ID = :WO_ID))
ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WO_ID" QueryStringField="WO_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>