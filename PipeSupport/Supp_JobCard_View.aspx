<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_JobCard_View.aspx.cs" Inherits="PipeSupport_Supp_JobCard_View"
    Title="Support JC" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 100px; background-color: gainsboro;">
                <asp:ImageButton ID="btnBack" runat="server" OnClick="btnBack_Click" ImageUrl="../Images/back_a.png" />
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:DetailsView ID="supportJcDetailsView" runat="server" AutoGenerateRows="False"
                    DataKeyNames="JC_ID,BOM_ID" DataSourceID="detailsDataSource" SkinID="DetailsViewSkin"
                    Width="600px" OnItemUpdating="wpsDetailsView_ItemUpdating" OnModeChanging="wpsDetailsView_ModeChanging">
                    <Fields>
                        <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                            ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />
                        <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1"
                            ReadOnly="true" />
                        <asp:BoundField DataField="REV_NO" HeaderText="Rev No" SortExpression="REV_NO" ReadOnly="true" />
                        <asp:BoundField DataField="FCR" HeaderText="FCR" SortExpression="FCR" ReadOnly="true" />
                        <asp:BoundField DataField="SCR" HeaderText="SCR" SortExpression="SCR" ReadOnly="true" />
                        <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="true" />
                        <asp:BoundField DataField="SPOOL" HeaderText="Spool Pice No" SortExpression="SPOOL"
                            ReadOnly="true" />
                        <asp:BoundField DataField="MAT_CLASS" HeaderText="Mat Class" SortExpression="MAT_CLASS"
                            ReadOnly="true" />
                        <asp:BoundField DataField="MAT_TYPE" HeaderText="Mat Type" SortExpression="MAT_TYPE"
                            ReadOnly="true" />
                        <asp:BoundField DataField="MAT_CODE1" HeaderText="Support Tag No" SortExpression="MAT_CODE1"
                            ReadOnly="true" />
                        <asp:BoundField DataField="SIZE_DESC" HeaderText="Support Size" SortExpression="SIZE_DESC"
                            ReadOnly="true" />
                        <asp:BoundField DataField="MAT_DESCR" HeaderText="Support Description" SortExpression="MAT_DESCR"
                            ReadOnly="true" />
                        <asp:TemplateField HeaderText="Mat Issue Date" SortExpression="MAT_ISSUE_DATE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MAT_ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("MAT_ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fabrication Date" SortExpression="FAB_DATE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FAB_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("FAB_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="QC Clear Date" SortExpression="QC_CLEAR_DATE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("QC_CLEAR_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("QC_CLEAR_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Paint Date" SortExpression="PAINT_DATE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("PAINT_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("PAINT_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Final Inspection" SortExpression="FINAL_INSPEC">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("FINAL_INSPEC", "{0:dd-MMM-yyyy}") %>'
                                    Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("FINAL_INSPEC", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Jobcard Qty" SortExpression="JC_QTY">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("JC_QTY") %>' Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("JC_QTY") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="UNIT_WT" HeaderText="Unit Weight" SortExpression="UNIT_WT"
                            ReadOnly="True" />
                        <asp:BoundField DataField="TOTAL_WT" HeaderText="Total Weight" SortExpression="TOTAL_WT"
                            ReadOnly="true" />
                        <asp:TemplateField HeaderText="Consider Shop BOM" SortExpression="CONSIDER_SHOP_BOM">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddConsiderShopBOM" runat="server" SelectedValue='<%# Bind("CONSIDER_SHOP_BOM") %>' Width="60px">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("CONSIDER_SHOP_BOM") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="REMARKS" SortExpression="REMARKS">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("REMARKS") %>' Width="90%"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label10" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="detailsDataSource" runat="server" SelectMethod="GetDataByBOM_ID"
        TypeName="dsSupp_BTableAdapters.VIEW_ADP_SUPP_JC_DTTableAdapter" UpdateMethod="UpdateQuery"
        OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="JC_QTY" Type="Decimal" />
            <asp:Parameter Name="MAT_ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="FAB_DATE" Type="DateTime" />
            <asp:Parameter Name="QC_CLEAR_DATE" Type="DateTime" />
            <asp:Parameter Name="PAINT_DATE" Type="DateTime" />
            <asp:Parameter Name="FINAL_INSPEC" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="CONSIDER_SHOP_BOM" Type="String" />
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JC_ID" QueryStringField="JC_ID"
                Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="BOM_ID" QueryStringField="BOM_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>