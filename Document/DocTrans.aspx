<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocTrans.aspx.cs"
    MasterPageFile="~/MasterPage.master" Inherits="Isome_DocTrans" Title="Document Transmittal" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>

        <div>
            <table style="width: 100%; background-color: gainsboro">
                <tr>
                    <td>
                        <telerik:RadButton ID="btnRegister" runat="server" Text="Register" Width="100" OnClick="btnRegister_Click" CausesValidation="false"></telerik:RadButton>
                    </td>
                    <td>
                        <telerik:RadButton ID="btnDocList" runat="server" Text="Documents List" Width="150" OnClick="btnDocList_Click" CausesValidation="false"></telerik:RadButton>
                    </td>
                    <td>
                        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="150px" OnClick="btnPreview_Click" CausesValidation="false"></telerik:RadButton>
                    </td>
                    <td style="width: 100%; text-align: right"></td>
                </tr>
            </table>
        </div>

        <div style="margin-top: 5px">
            <table runat="server" id="EntryTable" visible="false">
                <tr>
                    <td>Transmittal Number : </td>
                    <td>
                        <telerik:RadTextBox ID="txtTransNo" runat="server" Width="220px" AutoPostBack="true"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>Transmittal Date : </td>
                    <td>
                        <telerik:RadDatePicker ID="txtTransDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="220px"></telerik:RadDatePicker>
                        <asp:RequiredFieldValidator ID="TransDateValidator" runat="server" ControlToValidate="txtTransDate"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Vendor: </td>
                    <td>
                        <telerik:RadDropDownList ID="ddlVendorList" runat="server" Width="220px" DataSourceID="vendorSource"
                            DataTextField="VENDOR_NAME" DataValueField="VENDOR_ID" OnSelectedIndexChanged="vendorList_IndexChanged" AutoPostBack="true" CausesValidation="false">
                        </telerik:RadDropDownList>
                    </td>
                </tr>
                <tr>
                    <td>To: </td>
                    <td>
                        <telerik:RadDropDownList ID="ddlTo" runat="server" Width="220px" OnSelectedIndexChanged="ddlTo_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                            <Items>
                                <telerik:DropDownListItem Text="DCC" Value="DCC" Selected="true" />
                                <telerik:DropDownListItem Text="SITE" Value="SITE-DCC" />
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Attention To : </td>
                    <td>
                        <telerik:RadTextBox ID="txtAttnTo" runat="server" Width="220px"></telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="AttnFieldValidator" runat="server" ControlToValidate="txtAttnTo"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>

                    </td>
                </tr>
                <tr>
                    <td>Subject : </td>
                    <td>
                        <telerik:RadTextBox ID="txtSubject" runat="server" Width="220px"></telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="SubjectFieldValidator" runat="server" ControlToValidate="txtSubject"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Category: </td>
                    <td>
                        <telerik:RadDropDownList ID="ddlCategory" runat="server" Width="220px">
                            <Items>
                                <telerik:DropDownListItem Text="For Approval" Value="For Approval"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="For Review" Value="For Review"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="For Information" Value="For Information"></telerik:DropDownListItem>
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Purpose: </td>
                    <td>
                        <telerik:RadDropDownList ID="ddlPurpose" runat="server" Width="220px">
                            <Items>
                                <telerik:DropDownListItem Text="1st Submission" Value="1st Submission"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="Re-issue" Value="Re-issue"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="For HAZOP" Value="For HAZOP"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="For Desing/Procurement/Fabrication" Value="For Desing/Procurement/Fabrication"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="For Construction" Value="For Construction"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="As-Built" Value="As-Built"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="Final Issue" Value="Final Issue"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="For Information" Value="For Information"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="For Action" Value="For Action"></telerik:DropDownListItem>
                            </Items>
                        </telerik:RadDropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Remarks : </td>
                    <td>
                        <telerik:RadTextBox ID="txtRemarks" runat="server" Width="220px"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <telerik:RadButton ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click"></telerik:RadButton>
                    </td>
                </tr>
            </table>
        </div>
        <div style="margin-top: 5px">
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="true" AllowPaging="True" DataSourceID="itemsDataSource" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                GroupPanelPosition="Top">
                <ClientSettings Selecting-AllowRowSelect="true">
                </ClientSettings>
                <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="TRANS_ID"
                    ClientDataKeyNames="TRANS_ID" AllowAutomaticDeletes="true" EditMode="InPlace">
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                            <ItemStyle CssClass="MyImageButton" Width="10px" />
                        </telerik:GridEditCommandColumn>

                        <%-- GRID VIEW DELETE COLUMN --%>
                        <telerik:GridButtonColumn ConfirmText="Delete this Transmittal?" ConfirmDialogType="RadWindow"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                            UniqueName="DeleteColumn">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="20px" />
                        </telerik:GridButtonColumn>
                        <%-- GRID VIEW DELETE COLUMN END --%>
                        <telerik:GridBoundColumn DataField="TRANS_NO" FilterControlAltText="Filter TRANS_NO column" HeaderText="Transmittal No" SortExpression="TRANS_NO" UniqueName="TRANS_NO" AllowFiltering="true" ReadOnly="true">
                            <ItemStyle Width="200px" />
                        </telerik:GridBoundColumn>
                          <telerik:GridTemplateColumn AllowFiltering="False" DataField="TRANS_DATE" DataType="System.DateTime" FilterControlAltText="Filter TRANS_DATE column" HeaderText="Transmittal Date" SortExpression="TRANS_DATE" UniqueName="TRANS_DATE">
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="txtTransDate" runat="server" DbSelectedDate='<%# Bind("TRANS_DATE") %>'
                                    DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTransDate" runat="server" Text='<%# Eval("TRANS_DATE", "{0:dd-MMM-yyyy}") %>' Width="120px"></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>


                        <telerik:GridBoundColumn DataField="VENDOR_NAME" FilterControlAltText="Filter VENDOR_NAME column" HeaderText="Vendor Name" SortExpression="VENDOR_NAME" UniqueName="VENDOR_NAME" AllowFiltering="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ATTENTION" FilterControlAltText="Filter ATTENTION column" HeaderText="Attention To" SortExpression="ATTENTION" UniqueName="ATTENTION" AllowFiltering="false">
                        </telerik:GridBoundColumn>
                  

                        <telerik:GridTemplateColumn AllowFiltering="False" DataField="ACKNOWLEDGE_DATE" DataType="System.DateTime" FilterControlAltText="Filter ACKNOWLEDGE_DATE column" HeaderText="Acknowledge Date" SortExpression="ACKNOWLEDGE_DATE" UniqueName="ACKNOWLEDGE_DATE">
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="txtAckDate" runat="server" DbSelectedDate='<%# Bind("ACKNOWLEDGE_DATE") %>'
                                    Width="120px">
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAckDate" runat="server" Text='<%# Eval("ACKNOWLEDGE_DATE", "{0:dd-MMM-yyyy}") %>' Width="120px"></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="PURPOSE" FilterControlAltText="Filter PURPOSE column" HeaderText="Purpose" SortExpression="PURPOSE" UniqueName="PURPOSE" AllowFiltering="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CATEGORY" FilterControlAltText="Filter CATEGORY column" HeaderText="Category" SortExpression="CATEGORY" UniqueName="CATEGORY" AllowFiltering="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                       

                         <telerik:GridTemplateColumn HeaderText="Remarks" SortExpression="REMARKS" AllowFiltering="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Bind("REMARKS") %>' Width="100px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle Width="50px" />
                        <ItemTemplate>
                            <asp:Label ID="lblRemakrs" runat="server" Text='<%# Bind("REMARKS") %>' Width="100px"></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>


        <asp:SqlDataSource ID="vendorSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT VENDOR_ID,VENDOR_NAME FROM DCS_TRANS_VENDOR ORDER BY VENDOR_ID"></asp:SqlDataSource>
        <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" 
              UpdateMethod="UpdateQuery" SelectMethod="GetData" TypeName="dsMasterTransTableAdapters.DCS_TRANS_MASTERTableAdapter">
            <DeleteParameters>
                <asp:Parameter Name="original_TRANS_ID" Type="Decimal" />
            </DeleteParameters>
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            </SelectParameters>
            <UpdateParameters>
               <asp:Parameter Name="TRANS_DATE" Type="DateTime" />
                <asp:Parameter Name="ATTENTION" Type="String" />
                <asp:Parameter Name="ACKNOWLEDGE_DATE" Type="DateTime" />
                <asp:Parameter Name="REMARKS" Type="String" />
                <asp:Parameter Name="original_TRANS_ID" Type="Decimal" />
            </UpdateParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>
