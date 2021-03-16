<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="RT100.aspx.cs" Inherits="WeldingInspec_FieldJointsPaint" Title="Joints Paiting" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnViewJoints" runat="server" Text="Joints" Width="80" OnClick="btnViewJoints_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNew" runat="server" Text="New" Width="80"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" AutoPostBack="true" EmptyMessage="Search" runat="server" Width="250"></telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="TransGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="JntPaintDataSource" PageSize="18" SkinID="GridViewSkin"
            Width="100%" DataKeyNames="LIST_ID" OnRowUpdating="TransGridView_RowUpdating"
            OnDataBound="TransGridView_DataBound">
            <Columns>
                <asp:CommandField ShowEditButton="False" ShowSelectButton="True" ButtonType="Image"
                    CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif" UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="30px" />
                </asp:CommandField>
                <asp:BoundField DataField="ISO_TITLE1" HeaderText="First Joint Iso Title" SortExpression="ISO_TITLE1" />
                <asp:BoundField DataField="JOINT_NO" HeaderText="First Joint No" SortExpression="JOINT_NO" />
                <asp:BoundField DataField="WELDER_NO" HeaderText="Welder No" SortExpression="WELDER_NO" />
                <asp:BoundField DataField="REJ_ISO_TITLE1" HeaderText="Rej Iso Title" SortExpression="REJ_ISO_TITLE1" />
                <asp:BoundField DataField="REJ_JOINT_NO" HeaderText="Rej Joint No" SortExpression="REJ_JOINT_NO" />
                <asp:BoundField DataField="WELD_DATE" HeaderText="Weld Date" SortExpression="WELD_DATE" HtmlEncode="false" DataFormatString="{0:dd-MMM-yyyy}" />
                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
            </Columns>
        </asp:GridView>
    </div>

    <div style="background-color: whitesmoke;">
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

    <asp:ObjectDataSource ID="JntPaintDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsRT100TableAdapters.VIEW_RT_100TableAdapter" OldValuesParameterFormatString="original_{0}" DeleteMethod="DeleteQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_LIST_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="ISO_TITLE1" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>