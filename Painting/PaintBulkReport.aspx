<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PaintBulkReport.aspx.cs" Inherits="Painting_PaintBulkReport" Title="Paint Reports" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: gainsboro">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" Visible="false" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80" OnClick="btnEntry_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" Width="212px"
                        AutoPostBack="True">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="130px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table width="100%" runat="server" visible="false" id="EntryTable">
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Paint Jobcard No
                </td>
                <td>
                    <asp:DropDownList ID="ddJobcardNo" runat="server" Width="220px" DataSourceID="JobcardNoSqlDataSource"
                        DataTextField="PAINT_REQ_NO" DataValueField="PAINT_ID" OnSelectedIndexChanged="ddJobcardNo_SelectedIndexChanged"
                        AutoPostBack="True">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Paint Report No
                </td>
                <td>
                    <asp:TextBox ID="txtPaintRepNo" runat="server" Width="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Paint Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtPaintDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="PaintDateValidator" runat="server" ControlToValidate="txtPaintDate"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Paint Code
                </td>
                <td>
                    <asp:DropDownList ID="ddPaintCode" runat="server" Width="100px" DataSourceID="PaintCodeSqlDataSource"
                        DataTextField="PAINT_CODE" DataValueField="PAINT_CODE" AppendDataBoundItems="True"
                        OnDataBinding="ddPaintCode_DataBinding">
                    </asp:DropDownList>
                    <asp:CompareValidator ID="PaintCodeValidator" runat="server" ControlToValidate="ddPaintCode"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Coating Layer
                </td>
                <td>
                    <asp:DropDownList ID="ddCoatLayer" runat="server" Width="200px" DataSourceID="PaintCoatSqlDataSource"
                        DataTextField="PAINT_COAT" DataValueField="COAT_ID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Item Code
                </td>
                <td>
                    <asp:DropDownList ID="ddItemCode" runat="server" Width="200px" DataSourceID="MatCodeSqlDataSource"
                        DataTextField="MAT_CODE1" DataValueField="MAT_ID" AppendDataBoundItems="True"
                        OnDataBinding="ddItemCode_DataBinding">
                    </asp:DropDownList>
                    <asp:CompareValidator ID="ItemCodeValidator" runat="server" ControlToValidate="ddItemCode"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Paint Qty
                </td>
                <td>
                    <asp:TextBox ID="txtPaintQty" runat="server" Width="70px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PaintQtyValidator" runat="server" ControlToValidate="txtPaintQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Paint Area
                </td>
                <td>
                    <asp:TextBox ID="txtPaintArea" runat="server" Width="70px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PaintAreaValidator" runat="server" ControlToValidate="txtPaintArea"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="itemsDataSource" Width="100%" OnRowEditing="itemsGridView_RowEditing" SkinID="GridViewSkin"
            OnDataBound="itemsGridView_DataBound" PageSize="18" DataKeyNames="PAINT_ID,COAT_ID,MAT_ID,PAINT_DATE">
            <MasterTableView AllowAutomaticUpdates="true" DataKeyNames="PAINT_ID,COAT_ID,MAT_ID,PAINT_DATE">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    
                    <telerik:GridBoundColumn DataField="PAINT_REP_NO" HeaderText="Paint Report No" SortExpression="PAINT_REP_NO" />
                    <telerik:GridBoundColumn DataField="PAINT_DATE" HeaderText="Paint Date" SortExpression="PAINT_DATE"
                        DataFormatString="{0:dd-MMM-yyyy}"/>
                    <telerik:GridBoundColumn DataField="PAINT_REQ_NO" HeaderText="Paint Req No" SortExpression="PAINT_REQ_NO"
                        ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="PAINT_CODE" HeaderText="Paint Code" SortExpression="PAINT_CODE" />                    
                    <telerik:GridTemplateColumn HeaderText="Paint Coat" SortExpression="PAINT_COAT">
                        <edititemtemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" Width="100px" DataSourceID="PaintCoatSqlDataSource"
                            DataTextField="PAINT_COAT" DataValueField="COAT_ID" SelectedValue='<%# Bind("COAT_ID") %>'>
                        </asp:DropDownList>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("PAINT_COAT") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Item Code" SortExpression="MAT_CODE1"
                        ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="PAINT_QTY" HeaderText="Paint Qty" SortExpression="PAINT_QTY" />
                    <telerik:GridBoundColumn DataField="PAINT_AREA" HeaderText="Paint Area" SortExpression="PAINT_AREA" />
                    <telerik:GridBoundColumn DataField="PAINT_SURF" HeaderText="Paint Surf" SortExpression="PAINT_SURF" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div style="background-color: gainsboro">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="80" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="80" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPaintingRepsTableAdapters.VIEW_ADP_PAINTING_REPORTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_PAINT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_COAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_PAINT_DATE" Type="DateTime" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PAINT_REP_NO" Type="String" />
            <asp:Parameter Name="PAINT_DATE" Type="DateTime" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="COAT_ID" Type="Decimal" />
            <asp:Parameter Name="PAINT_QTY" Type="Decimal" />
            <asp:Parameter Name="PAINT_SURF" Type="Decimal" />
            <asp:Parameter Name="PAINT_AREA" Type="String" />
            <asp:Parameter Name="Original_PAINT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_COAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_PAINT_DATE" Type="DateTime" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="PAINT_REQ_NO"
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="PaintCoatSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT COAT_ID, PAINT_COAT FROM PIP_PAINT_COAT WHERE COAT_ID = 3"></asp:SqlDataSource>
    <asp:SqlDataSource ID="JobcardNoSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PAINT_ID, PAINT_REQ_NO FROM PIP_PAINTING_MAT WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY PAINT_REQ_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MatCodeSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_ID, MAT_CODE1 FROM VIEW_PAINTING_MAT_DETAIL WHERE (PAINT_ID = :PAINT_ID) ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddJobcardNo" DefaultValue="-1" Name="PAINT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="PaintCodeSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PAINT_CODE FROM VIEW_PAINTING_MAT_DETAIL WHERE (PAINT_ID = :PAINT_ID) ORDER BY PAINT_CODE">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddJobcardNo" DefaultValue="-1" Name="PAINT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
