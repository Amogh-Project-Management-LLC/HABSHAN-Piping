<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Isome_SuppFab.aspx.cs" Inherits="Isome_SuppFab"
    Title="Details" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <asp:DetailsView ID="supportJcDetailsView" runat="server" AutoGenerateRows="False" DataKeyNames="BOM_ID"
                    DataSourceID="DetailsView_SqlDataSource"
                    SkinID="DetailsViewSkin" Width="600px" OnItemUpdating="supportJcDetailsView_ItemUpdating">
                    <FieldHeaderStyle Width="180px" />
                    <Fields>
                        <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif"
                            EditImageUrl="~/Images/icon-edit.gif" SelectImageUrl="~/Images/icon-select.gif"
                            UpdateImageUrl="~/Images/icon-save.gif" />

                        <asp:BoundField DataField="ISO_TITLE1" HeaderText="isometric No" SortExpression="ISO_TITLE1" ReadOnly="true" />
                        <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="true" />
                        <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="true" />
                        <asp:BoundField DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" ReadOnly="true" />
                        <asp:BoundField DataField="MAT_CODE1" HeaderText="Support Tag No" SortExpression="MAT_CODE1" ReadOnly="true" />
                        <asp:BoundField DataField="MAT_DESCR" HeaderText="Support Description" SortExpression="MAT_DESCR" ReadOnly="true" />

                        <asp:BoundField DataField="SUPP_JC_NO" HeaderText="Support Fab JC No" SortExpression="SUPP_JC_NO" ReadOnly="true" />
                        <asp:BoundField DataField="SUPP_JC_DATE" HeaderText="Support Fab JC Date" SortExpression="SUPP_JC_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ReadOnly="true" />
                        <asp:BoundField DataField="SF_FLG" HeaderText="SF" SortExpression="SF_FLG" ReadOnly="true" />
                        <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" ReadOnly="true" />
                        <asp:BoundField DataField="NET_QTY" HeaderText="Qty" SortExpression="NET_QTY" ReadOnly="true" />
                        <asp:BoundField DataField="MAT_ISSUE_DATE" HeaderText="Mat Issue Date" SortExpression="MAT_ISSUE_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />

                        <asp:BoundField DataField="FAB_DATE" HeaderText="Fabrication Date" SortExpression="FAB_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />

                        <asp:BoundField DataField="QC_CLEAR_DATE" HeaderText="QC Clear Date" SortExpression="QC_CLEAR_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />

                        <asp:BoundField DataField="PAINT_REP_NO" HeaderText="Paint Rep No" SortExpression="PAINT_REP_NO" />

                        <asp:BoundField DataField="PAINT_DATE" HeaderText="Paint Date" SortExpression="PAINT_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />

                        <asp:BoundField DataField="FINAL_INSPEC" HeaderText="Final Inspection Date" SortExpression="FINAL_INSPEC"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                    </Fields>
                </asp:DetailsView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:SqlDataSource ID="DetailsView_SqlDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT BOM_ID, ISO_TITLE1, SHEET, SPOOL, PT_NO, MAT_CODE1, MAT_DESCR, SF_FLG, UOM, NET_QTY, SUPP_JC_NO, SUPP_JC_DATE, SUPP_FAB_SHOP_NO, FAB_DATE, MAT_ISSUE_DATE, QC_CLEAR_DATE, PAINT_DATE, PAINT_REP_NO, FINAL_INSPEC FROM VIEW_TOTAL_SUPP WHERE (BOM_ID = :BOM_ID)" UpdateCommand="UPDATE PIP_SUPP_JC_DETAIL SET MAT_ISSUE_DATE = :MAT_ISSUE_DATE, FAB_DATE = :FAB_DATE, QC_CLEAR_DATE = :QC_CLEAR_DATE, PAINT_DATE = :PAINT_DATE, FINAL_INSPEC = :FINAL_INSPEC, PAINT_REP_NO = :PAINT_REP_NO WHERE (BOM_ID = :BOM_ID)">
        <SelectParameters>            
            <asp:QueryStringParameter DefaultValue="-1" Name="BOM_ID" QueryStringField="BOM_ID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MAT_ISSUE_DATE" />
            <asp:Parameter Name="FAB_DATE" />
            <asp:Parameter Name="QC_CLEAR_DATE" />
            <asp:Parameter Name="PAINT_DATE" />
            <asp:Parameter Name="FINAL_INSPEC" />
            <asp:Parameter Name="PAINT_REP_NO" />
            <asp:Parameter Name="BOM_ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>