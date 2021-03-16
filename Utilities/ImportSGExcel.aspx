<%@ Page Title="Spoolgen Data Import" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ImportSGExcel.aspx.cs" Inherits="Utilities_ImportTalismanData" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100" OnClick="btnBack_Click"></telerik:RadButton>
    </div>


    <div style="width: 700px; margin-top: 3px; border: 1px solid #98EDFF; display: inline-block;">
        <div style="background-color: #DDF5FA; height: 50px; vertical-align: middle; padding: 5px; font-weight: 500;">
            <table>
                <tr>
                    <td>
                        <telerik:RadLabel ID="headertext" runat="server" Text="Import Excel Files"></telerik:RadLabel>
                    </td>
                    <td>
                        <telerik:RadRadioButtonList ID="importformat" runat="server" Layout="Flow" Direction="Horizontal" AutoPostBack="true"
                            OnSelectedIndexChanged="importformat_SelectedIndexChanged" CausesValidation="false">
                            <Items>
                                <telerik:ButtonListItem Text="STANDARD" Value="AMOGH_DATA_IMPORT" Selected="true" />
                                <telerik:ButtonListItem Text="EPIC" Value="EPIC_DATA_IMPORT" />
                            </Items>
                        </telerik:RadRadioButtonList>
                    </td>
                </tr>
            </table>
        </div>
        <table runat="server" style="margin-top: 5px; height: 200px; padding-left: 5px" id="Amogh_format">
            <tr>
                <td>CutList File
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadCutList" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink1" runat="server">CutList Sample File</asp:HyperLink>
                </td>

                <td style="padding-left: 50px">
                    <telerik:RadButton ID="btnCutlist" runat="server" Visible="false" ForeColor="Red" Text="CutList Errors" Width="140" OnClick="btnCutlist_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td>Spool File
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadSpoolStatus" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink2" runat="server">Spool Sample File</asp:HyperLink>
                </td>
                <td style="padding-left: 50px">
                    <telerik:RadButton ID="btnSpool" runat="server" Visible="false" ForeColor="Red" Text="Spool Errors" Width="140" OnClick="btnSpool_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td>Joints File
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadWeldMTO" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink3" runat="server">Joint Sample File</asp:HyperLink>
                </td>
                <td style="padding-left: 50px">
                    <telerik:RadButton ID="btnJoint" runat="server" Visible="false" ForeColor="Red" Text="Joint Errors" Width="140" OnClick="btnJoint_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td>LOM File
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadBOM" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink4" runat="server">LOM Sample File</asp:HyperLink>
                </td>
                <td style="padding-left: 50px">
                    <telerik:RadButton ID="btnLom" runat="server" Visible="false" ForeColor="Red" Text="Lom Errors" Width="140" OnClick="btnLom_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td>Flange File
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadFlange" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink5" runat="server">SiteJoint Sample File</asp:HyperLink>
                </td>
                <td style="padding-left: 50px">
                    <telerik:RadButton ID="btnFlange" runat="server" Visible="false" ForeColor="Red" Text="Flange Errors" Width="140" OnClick="btnFlange_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td></td>
                <td colspan="2">
                    <telerik:RadButton ID="btnUploadAmogh" runat="server" Text="Upload" Width="85" OnClick="btnUploadAmogh_Click" Visible="true"></telerik:RadButton>
                    <%--   <telerik:RadButton ID="btnUpload" runat="server" Text="Upload" Width="85" OnClick="btnUpload_Click" Visible="true"></telerik:RadButton>--%>
                    <telerik:RadButton ID="btnRun" runat="server" Text="Run" Width="85" OnClick="btnRun_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
        <table runat="server" style="margin-top: 5px; height: 200px; padding-left: 5px" id="Epic_format" visible="false">

            <tr>
                <td>Spool File
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadEpicSpool" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink6" runat="server">Spool Sample File</asp:HyperLink>
                </td>
                <td style="padding-left: 50px">
                    <telerik:RadButton ID="btnEpicSpool" runat="server" Visible="false" ForeColor="Red" Text="Spool Errors" Width="140" OnClick="btnEpicSpool_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td>Joints File
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadEpicJoint" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink7" runat="server">Joints Sample File</asp:HyperLink>
                </td>
                <td style="padding-left: 50px">
                    <telerik:RadButton ID="btnEpicJoint" runat="server" Visible="false" ForeColor="Red" Text="Joint Errors" Width="140" OnClick="btnEpicJoint_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td>BOM File
                </td>
                <td>
                    <asp:FileUpload ID="fileUploadEpicBom" runat="server" />
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink8" runat="server">Bom Sample File</asp:HyperLink>
                </td>
                <td style="padding-left: 50px">
                    <telerik:RadButton ID="btnEpicBom" runat="server" Visible="false" ForeColor="Red" Text="Bom Errors" Width="140" OnClick="btnEpicBom_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>

            <tr>
                <td></td>
                <td colspan="2">
                    <telerik:RadButton ID="btnUploadEPIC" runat="server" Text="Upload" Width="85" OnClick="btnUploadEPIC_Click" Visible="true"></telerik:RadButton>
                    <%--<telerik:RadButton ID="btnEpicUplod" runat="server" Text="Upload" Width="85" OnClick="btnEpicUpload_Click" Visible="true"></telerik:RadButton>--%>
                    <telerik:RadButton ID="btnEpicRun" runat="server" Text="Run" Width="85" OnClick="btnEpicRun_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>

        <div style="background-color: #F8FACE; color: maroon">
            <div style="font-weight: 500; height: 25px; padding-top: 4px; padding-left: 3px">Import Instructions:</div>
            <div style="padding-left: 10px;">
                1. Please choose correct sample file to upload data.<br />
                2. Do not change the column heading in sample file.
                <br />
                3. Do not change the file name.
                <br />
            </div>

        </div>


    </div>

    <div style="display: inline-block; float: right;">

        <telerik:RadTextBox RenderMode="Lightweight" ID="txtEpicOutput" runat="server" Width="400px" Height="350px" TextMode="MultiLine" Resize="Both" Visible="false" BorderWidth="5" BorderColor="#98EDFF" ReadOnly="true"></telerik:RadTextBox>
        <telerik:RadTextBox RenderMode="Lightweight" ID="txtAmoghOutput" runat="server" Width="400px" Height="350px" TextMode="MultiLine" Resize="Both" Visible="false" BorderWidth="5" BorderColor="#98EDFF" ReadOnly="true"></telerik:RadTextBox>
    </div>
   <div style="display: inline-block; float: right; ">
        <table style="padding:5px;">
              <tr>
                <td style="padding:5px">
                    <telerik:RadButton ID="AmpBalFlangeJoints" runat="server" Visible="false" ForeColor="Red" Text="Balance Flange Joints" Width="140" OnClick="AmpBalFlangeJoints_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td style="padding:5px">
                    <telerik:RadButton ID="AmgBaljoints" runat="server" Visible="false" ForeColor="Red" Text="Balance Joints" Width="140" OnClick="AmgBaljoints_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
          
            <tr>
                <td style="padding:5px">
                    <telerik:RadButton ID="AmgBalBom" runat="server" Visible="false" ForeColor="Red" Text="Balance Bom" Width="140" OnClick="AmgBalBom_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td style="padding:5px">
                    <telerik:RadButton ID="AmgBalSpool" runat="server" Visible="false" ForeColor="Red" Text="Balance Spool" Width="140" OnClick="AmgBalSpool_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td style="padding:5px">
                    <telerik:RadButton ID="EpicBalJoint" runat="server" Visible="false" ForeColor="Red" Text="Balance Joints" Width="140" OnClick="EpicBalJoint_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td style="padding:5px">
                    <telerik:RadButton ID="EpicBalBom" runat="server" Visible="false" ForeColor="Red" Text="Balance Bom" Width="140" OnClick="EpicBalBom_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td style="padding:5px">
                    <telerik:RadButton ID="EpicBalSpool" runat="server" Visible="false" ForeColor="Red" Text="Balance Spool" Width="140" OnClick="EpicBalSpool_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="AmoghCutList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM CLIENT_CUT_LIST_AMOGH WHERE IMPORT_REMARKS IS NOT NULL"></asp:SqlDataSource>
    <asp:SqlDataSource ID="AmoghSpoolList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM CLIENT_SPOOL_AMOGH WHERE IMPORT_REMARKS IS NOT NULL"></asp:SqlDataSource>
    <asp:SqlDataSource ID="AmoghJointList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM CLIENT_JOINT_AMOGH WHERE IMPORT_REMARKS IS NOT NULL"></asp:SqlDataSource>
    <asp:SqlDataSource ID="AmoghLomList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM CLIENT_LOM_AMOGH WHERE IMPORT_REMARKS IS NOT NULL"></asp:SqlDataSource>
    <asp:SqlDataSource ID="AmoghSiteJointList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM CLIENT_SITE_JOINT_AMOGH WHERE IMPORT_REMARKS IS NOT NULL"></asp:SqlDataSource>

    <asp:SqlDataSource ID="EpicSpoolList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM CLIENT_SPOOL_DATA_EPIC WHERE IMPORT_REMARKS IS NOT NULL"></asp:SqlDataSource>
    <asp:SqlDataSource ID="EpicJointList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM CLIENT_JOINT_EPIC WHERE IMPORT_REMARKS IS NOT NULL"></asp:SqlDataSource>
    <asp:SqlDataSource ID="EpicBomList" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM CLIENT_BOM_N_JC_EPIC WHERE IMPORT_REMARKS IS NOT NULL"></asp:SqlDataSource>


    <asp:SqlDataSource ID="sqlAmgBaljoints" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SG_AMOGH_BAL_JNT"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlAmpBalFlangeJoints" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SG_AMOGH_BAL_FLANGE_JNT"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlAmgBalBom" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SG_AMOGH_BAL_BOM"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlAmgBalSpool" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SG_AMOGH_BAL_SPL"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlEpicBalJoint" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SG_EPIC_BAL_JNT"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlEpicBalBom" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SG_EPIC_BAL_BOM"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlEpicBalSpool" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SG_EPIC_BAL_SPL"></asp:SqlDataSource>

</asp:Content>

