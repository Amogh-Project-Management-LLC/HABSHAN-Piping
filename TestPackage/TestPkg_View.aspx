<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TestPkg_View.aspx.cs" Inherits="TestPkg_TestPkg_View" Title="Test Package Details" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; background-color: whitesmoke">
                <telerik:RadButton ID="btnBak" runat="server" 
                    OnClick="btnBak_Click" Text="Back" Width="80px" />
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CssClass="DataWebControlStyle"
                    DataKeyNames="TPK_ID" DataSourceID="tpDataSource" Height="50px" Width="638px" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="None">
                    <Fields>
                        <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif"
                            EditImageUrl="~/Images/icon-edit.gif" SelectImageUrl="~/Images/icon-select.gif"
                            UpdateImageUrl="~/Images/icon-save.gif" />
                        <asp:BoundField DataField="TPK_NUMBER" HeaderText="Test Package No" SortExpression="TPK_NUMBER" />
                        <asp:BoundField DataField="SYS_NUMBER" HeaderText="System No" SortExpression="SYS_NUMBER"
                            ReadOnly="true" />
                        <asp:BoundField DataField="SUB_SYS_NO" HeaderText="Sub-System No" SortExpression="SUB_SYS_NO"
                            ReadOnly="true" />
                        <asp:BoundField DataField="TEST_PRESS" HeaderText="Test Pressure" SortExpression="TEST_PRESS" />
                        <asp:BoundField DataField="TEST_MEDIA" HeaderText="Test Media" SortExpression="TEST_MEDIA" />
                        <asp:BoundField DataField="LINE_SRV" HeaderText="Line Service" SortExpression="LINE_SRV" />
                        <asp:BoundField DataField="REVIEW_DATE" HeaderText="Review Date" SortExpression="REVIEW_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="TARGET_PRESR_TEST" HeaderText="Target Pressure Test Date"
                            SortExpression="TARGET_PRESR_TEST" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"
                            ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="TARGET_HO_COMM" HeaderText="Target H/O to Comm." SortExpression="TARGET_HO_COMM"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="TARGET_PUNCH_CLR" HeaderText="Target Punch Clear Date"
                            SortExpression="TARGET_PUNCH_CLR" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"
                            ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="ISSUED_FOR_LINE_CHECK" HeaderText="Issued for Line Check"
                            SortExpression="ISSUED_FOR_LINE_CHECK" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                        <asp:BoundField DataField="CONST_LINE_CHK_COMPLT" HeaderText="Const. Line Check Complete"
                            SortExpression="CONST_LINE_CHK_COMPLT" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"
                            ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="ENGG_LINE_CHK_COMPLT" HeaderText="Engg. Line Check Complete"
                            SortExpression="ENGG_LINE_CHK_COMPLT" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"
                            ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="QC_LINE_CHK_COMPLT" HeaderText="QC. Line Check Complete"
                            SortExpression="QC_LINE_CHK_COMPLT" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"
                            ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="PAINT_INSULATION_DATE" HeaderText="Painting/Insulation Date"
                            SortExpression="PAINT_INSULATION_DATE" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"
                            ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="PUNCH_LIST_ISSUED_TO_SC" HeaderText="Punch List Issued to SC"
                            SortExpression="PUNCH_LIST_ISSUED_TO_SC" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"
                            ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="A1_PUNCH_CLEARED" HeaderText="A1 Punch Cleared" SortExpression="A1_PUNCH_CLEARED"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="READY_FOR_TEST_DATE" HeaderText="Ready for Test Date"
                            SortExpression="READY_FOR_TEST_DATE" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"
                            ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="PRESS_TEST_COMPLT" HeaderText="Pressure Test Complete Date"
                            SortExpression="PRESS_TEST_COMPLT" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"
                            ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="FLUSH_BLOWING_COMPLT" HeaderText="Flushing/Blowing Complete"
                            SortExpression="FLUSH_BLOWING_COMPLT" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"
                            ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="REINST_COMPLT" HeaderText="Reinst. Complete Date" SortExpression="REINST_COMPLT"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="A2_PUNCH_CLEARED" HeaderText="A2 Punch Clear Date" SortExpression="A2_PUNCH_CLEARED"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="WALK_THROUGH_DATE" HeaderText="Walk Through Date" SortExpression="WALK_THROUGH_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="HO_NOTICE_TO_COMM" HeaderText="H/O Notice to Comm." SortExpression="HO_NOTICE_TO_COMM"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="HO_TO_TURN_OVER" HeaderText="H/O to Turn Over" SortExpression="HO_TO_TURN_OVER"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                        <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                    </Fields>
                   
                    <FieldHeaderStyle Width="200px" />
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="tpDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDataByTPK_ID" TypeName="dsTestPkg_ATableAdapters.VIEW_ADAPTER_TPK_MASTERTableAdapter"
        UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TPK_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TPK_NUMBER" Type="String" />
            <asp:Parameter Name="TEST_PRESS" Type="String" />
            <asp:Parameter Name="TEST_MEDIA" Type="String" />
            <asp:Parameter Name="LINE_SRV" Type="String" />
            <asp:Parameter Name="REVIEW_DATE" Type="DateTime" />
            <asp:Parameter Name="TARGET_PRESR_TEST" Type="DateTime" />
            <asp:Parameter Name="TARGET_HO_COMM" Type="DateTime" />
            <asp:Parameter Name="TARGET_PUNCH_CLR" Type="DateTime" />
            <asp:Parameter Name="CONST_LINE_CHK_COMPLT" Type="DateTime" />
            <asp:Parameter Name="ENGG_LINE_CHK_COMPLT" Type="DateTime" />
            <asp:Parameter Name="QC_LINE_CHK_COMPLT" Type="DateTime" />
            <asp:Parameter Name="PAINT_INSULATION_DATE" Type="DateTime" />
            <asp:Parameter Name="PUNCH_LIST_ISSUED_TO_SC" Type="DateTime" />
            <asp:Parameter Name="A1_PUNCH_CLEARED" Type="DateTime" />
            <asp:Parameter Name="READY_FOR_TEST_DATE" Type="DateTime" />
            <asp:Parameter Name="PRESS_TEST_COMPLT" Type="DateTime" />
            <asp:Parameter Name="FLUSH_BLOWING_COMPLT" Type="DateTime" />
            <asp:Parameter Name="REINST_COMPLT" Type="DateTime" />
            <asp:Parameter Name="A2_PUNCH_CLEARED" Type="DateTime" />
            <asp:Parameter Name="WALK_THROUGH_DATE" Type="DateTime" />
            <asp:Parameter Name="HO_NOTICE_TO_COMM" Type="DateTime" />
            <asp:Parameter Name="HO_TO_TURN_OVER" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="ISSUED_FOR_LINE_CHECK" Type="DateTime" />
            <asp:Parameter Name="Original_TPK_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TPK_ID" QueryStringField="TPK_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
