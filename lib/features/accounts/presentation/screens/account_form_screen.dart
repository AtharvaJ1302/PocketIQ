import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/colors/app_gradients.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/finance/account_types.dart';
import '../../../../core/features/finance/bank_info.dart';
import '../../../../core/features/utils/validators.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/components/dropdown/pocket_dropdown.dart';
import '../../../../shared/components/info/info_tile.dart';
import '../../../../shared/components/inputs/pocket_text_field.dart';
import '../../../../shared/layouts/form_section.dart';
import '../providers/account_provider.dart';
import '../providers/add_account_notifier.dart';
import '../providers/account_form_provider.dart';
import 'package:flutter/services.dart';
import '../../domain/models/account.dart';
import '../widgets/account_bottom_bar.dart';
import '../widgets/account_details_section.dart';
import '../widgets/account_form_header.dart';
import '../widgets/account_information_section.dart';
import '../widgets/account_section_title.dart';

class AccountFormScreen extends ConsumerStatefulWidget {
  final Account? account;

  const AccountFormScreen({super.key, this.account});

  @override
  ConsumerState<AccountFormScreen> createState() => _AccountFormScreenState();
}

class _AccountFormScreenState extends ConsumerState<AccountFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _accountNameController;
  late final TextEditingController _accountNumberController;
  // late final TextEditingController _balanceController;
  late final FocusNode _accountNameFocusNode;
  late final FocusNode _accountNumberFocusNode;
  // late final FocusNode _balanceFocusNode;

  @override
  void initState() {
    super.initState();

    _accountNameController = TextEditingController();
    _accountNumberController = TextEditingController();
    // _balanceController = TextEditingController();

    _accountNameFocusNode = FocusNode();
    _accountNumberFocusNode = FocusNode();
    // _balanceFocusNode = FocusNode();

    if (widget.account != null) {
      final account = widget.account!;

      _accountNameController.text = account.accountName;
      _accountNumberController.text = account.accountNumber;
      // _balanceController.text =
      //     account.openingBalance.toStringAsFixed(2);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final notifier = ref.read(addAccountProvider);

        notifier.setBank(account.bankCode);
        notifier.setAccountType(account.accountType);
      });
    }
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountNumberController.dispose();
    // _balanceController.dispose();
    _accountNameFocusNode.dispose();
    _accountNumberFocusNode.dispose();
    // _balanceFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveAccount(AddAccountNotifier notifier) async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (notifier.selectedBank == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a bank.')));
      return;
    }

    if (notifier.selectedAccountType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an account type.')),
      );
      return;
    }

    if (widget.account == null) {
      await notifier.saveAccount(
        accountName: _accountNameController.text.trim(),
        accountNumber: _accountNumberController.text.trim(),
      );
    } else {
      await notifier.updateAccount(
        account: widget.account!,
        accountName: _accountNameController.text.trim(),
        accountNumber: widget.account!.accountNumber,
      );
    }

    await ref.read(accountProvider).loadAccounts();

    if (!mounted) return;

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(addAccountProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppGradients.screenBackground
                  : AppGradients.screenBackgroundLight,
            ),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverToBoxAdapter(
                      child: AccountFormHeader(
                        isEditing: widget.account != null,
                      ),
                    ),

                    SliverPadding(
                      padding: AppSpacing.screenPadding,
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const AccountSectionTitle(title: "Account Details"),

                          AccountDetailsSection(
                            isEditing: widget.account != null,

                            selectedBank: notifier.selectedBank,

                            selectedAccountType: notifier.selectedAccountType,

                            onBankChanged: notifier.setBank,

                            onAccountTypeChanged: notifier.setAccountType,

                            bankCode: widget.account?.bankCode,

                            accountType: widget.account?.accountType,

                            lastFourDigits: widget.account?.lastFourDigits,
                          ),

                          const SizedBox(height: AppSpacing.xxxl),

                          const AccountSectionTitle(
                            title: "Account Information",
                          ),

                          AccountInformationSection(
                            isEditing: widget.account != null,

                            accountNameController: _accountNameController,

                            accountNumberController: _accountNumberController,

                            accountNameFocusNode: _accountNameFocusNode,

                            accountNumberFocusNode: _accountNumberFocusNode,
                          ),

                          const SizedBox(height: AppSpacing.xxxl),

                          PocketButton(
                            label: widget.account == null
                                ? 'Add Account'
                                : 'Update Account',
                            loading: notifier.loading,
                            onPressed: () => _saveAccount(notifier),
                          ),

                          const SizedBox(height: AppSpacing.xxxl),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
